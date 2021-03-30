import 'package:fruty_chamoy_flutter/models/loginModel.dart';
import 'package:fruty_chamoy_flutter/models/responseRenewToken.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginModel model);
  Future<bool> logout();
  Future<ResponseRenewToken> renewToken();
}
