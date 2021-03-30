import 'package:bloc/bloc.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._authRepository) : super(HomeInitial());

  final AuthRepository _authRepository;

  void logout() async {
    final resp = await _authRepository.logout();
    if (resp) {
      emit(LogoutState());
    }
  }

  void renewToken() async {
    emit(RenewTokenState());
    final resp = await _authRepository.renewToken();
    if (resp != null) {
      StorageUtil.putString('token', resp.token);
      emit(HomeInitial());
    } else {
      emit(LogoutState());
    }
  }
}
