import 'package:bloc/bloc.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
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
}
