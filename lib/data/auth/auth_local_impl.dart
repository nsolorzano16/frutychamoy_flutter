import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
import 'package:fruty_chamoy_flutter/env/enviroment.dart';
import 'package:fruty_chamoy_flutter/models/loginModel.dart';
import 'package:http/http.dart' as http;

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
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
