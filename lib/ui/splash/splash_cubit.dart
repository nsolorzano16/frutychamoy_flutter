import 'package:bloc/bloc.dart';

import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());

  void existToken() {
    final token = StorageUtil.getString('token');
    print('OKEENE');
    print(token);
    if (token.isNotEmpty && token != null) {
      emit(LoggedState());
    } else {
      emit(SplashInitialState());
    }
  }
}
