import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/utils/const.dart';
import '../../../../../service/api_service.dart';
import 'login_bloc_state.dart';

class LoginBloc extends Cubit<LoginState> {
  ApiService apiService;

  LoginBloc(this.apiService)
      : super(const LoginState(loading: false, isSuccess: false));

  loginRequest(BuildContext context, String email, String password) async {
    emit(state.copyWith(loading: true));
    apiService.loginUser(email, password).then((res) {
      showToast(context, res);
      if (res == "success") {
        emit(state.copyWith(loading: false));
        emit(state.copyWith(isSuccess: true));
      } else {
        emit(state.copyWith(loading: false));
        emit(state.copyWith(isSuccess: false));
      }
    }, onError: (e) {
      emit(state.copyWith(loading: false));
      emit(state.copyWith(isSuccess: false));
      showToast(context, e.toString());
    });
  }

  setDefault(){
    emit(state.copyWith(loading: false));
    emit(state.copyWith(isSuccess: false));
  }
}
