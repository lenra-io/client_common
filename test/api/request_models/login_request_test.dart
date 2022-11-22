import 'dart:convert';

import 'package:client_common/api/request_models/login_request.dart';
import 'package:test/test.dart';

void main() {
  test('to json', () {
    LoginRequest loginRequest = LoginRequest("email", "password", true);
    Map<String, dynamic> json = jsonDecode(jsonEncode(loginRequest));
    expect(json["email"], "email");
    expect(json["password"], "password");
  });
}
