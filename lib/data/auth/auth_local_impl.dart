import 'package:fruty_chamoy_flutter/models/responseRenewToken.dart';
import 'package:http/http.dart' as http;
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
import 'package:fruty_chamoy_flutter/env/enviroment.dart';
import 'package:fruty_chamoy_flutter/models/loginModel.dart';
import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<LoginResponse> login(LoginModel model) async {
    final apiUrl = Uri.https(apiURL, '/api/auth');
    try {
      final resp = await http.post(
        apiUrl,
        body: loginModelToJson(model),
        headers: {'Content-Type': 'application/json'},
      );
      if (resp.statusCode == 200) {
        return loginResponseFromJson(resp.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logout() {
    return StorageUtil.remove('token');
  }

  @override
  Future<ResponseRenewToken> renewToken() async {
    final apiUrl = Uri.https(apiURL, '/api/auth/renew');
    try {
      final resp = await http.get(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'x-token': StorageUtil.getString('token'),
        },
      );
      if (resp.statusCode == 200) {
        return responseRenewTokenFromJson(resp.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
