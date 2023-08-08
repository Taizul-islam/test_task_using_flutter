
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_task/screen/trade/trade_bloc/trade_state.dart';


import '../../../model/trade_model.dart';
import '../../../service/api_service.dart';
import '../../../utils/const.dart';
import '../../auth/login_screen.dart';

class TradeBloc extends Cubit<TradeState>{
  ApiService apiService;
  TradeBloc(this.apiService): super(
     const TradeState(
          loading: false,
          isSuccess: false,
          tradeList: [],
          errorMessage: '',
          isFailed: false,
          totalProfit: 0.0));

  tradeData(BuildContext context,bool loading) async {
    emit(state.copyWith(loading: loading));
    apiService.getTrade().then((value) {
      if(value=="token_invalid"){
        clearPrefsData().then((value){
          Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
        });
        return;
      }
      emit(state.copyWith(loading: false));
      emit(state.copyWith(tradeList: value));
      emit(state.copyWith(isFailed: false));
      emit(state.copyWith(errorMessage: ""));
      if(!loading){
        showToast(context, "Refreshed");
      }
      if(state.tradeList.isNotEmpty){
        emit(state.copyWith(totalProfit: calculateTotalProfit(value)));
      }
    }, onError: (error) {
      emit(state.copyWith(loading: false));
      emit(state.copyWith(isFailed: true));
      emit(state.copyWith(errorMessage: error));
    });
  }

  calculateTotalProfit(List<TradeModel> list){
    var total=0.0;
    for(var item in list){
      total=total+(item.profit!.toDouble());
    }
    return total;
  }

}
