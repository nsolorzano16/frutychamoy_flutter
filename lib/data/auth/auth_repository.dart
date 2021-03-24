import 'package:fruty_chamoy_flutter/models/loginModel.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginModel model);
}
