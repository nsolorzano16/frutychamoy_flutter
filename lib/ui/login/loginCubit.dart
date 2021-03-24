import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';

import 'package:fruty_chamoy_flutter/models/loginModel.dart';
import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';
import 'package:meta/meta.dart';

part 'loginState.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginInitial());
  final AuthRepository _authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(LoginModel model) async {
    emit(LoadingState());
    final resp = await _authRepository.login(model);

    if (resp != null) {
      print(resp.toJson());
      StorageUtil.putString('token', resp.token);
      emit(SuccessState());
    } else {
      emit(FailureState());
    }
  }
}
