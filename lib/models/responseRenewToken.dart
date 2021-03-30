// To parse this JSON data, do
//
//     final responseRenewToken = responseRenewTokenFromJson(jsonString);

import 'dart:convert';

ResponseRenewToken responseRenewTokenFromJson(String str) =>
    ResponseRenewToken.fromJson(json.decode(str));

String responseRenewTokenToJson(ResponseRenewToken data) =>
    json.encode(data.toJson());

class ResponseRenewToken {
  ResponseRenewToken({
    this.ok,
    this.token,
  });

  bool ok;
  String token;

  factory ResponseRenewToken.fromJson(Map<String, dynamic> json) =>
      ResponseRenewToken(
        ok: json["ok"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "token": token,
      };
}
