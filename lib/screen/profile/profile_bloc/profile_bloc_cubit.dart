
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/model/profile_model.dart';
import 'package:test_task/screen/profile/profile_bloc/profile_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:test_task/utils/const.dart';

import '../../../service/api_service.dart';
import '../../auth/login_screen.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ApiService apiService;

  ProfileBloc(this.apiService)
      : super(ProfileState(
            loading: false,
            isSuccess: false,
            profileModel: ProfileModel(),
            errorMessage: '',
            isFailed: false));

  profileData(BuildContext context) async {
    emit(state.copyWith(loading: true));
    apiService.getAccountSettings().then((value) {
      emit(state.copyWith(errorMessage:""));
      if(value=="token_invalid"){
        clearPrefsData().then((value){
          Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
        });
        return;
      }
      emit(state.copyWith(loading: false));
      emit(state.copyWith(profileModel: value));
      emit(state.copyWith(isFailed: false));
      emit(state.copyWith(errorMessage:""));
    }, onError: (error) {
      emit(state.copyWith(loading: false));
      emit(state.copyWith(isFailed: true));
      emit(state.copyWith(errorMessage: error.toString()));
    });
  }
}
