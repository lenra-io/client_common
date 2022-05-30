import 'dart:convert';

import 'package:client_common/api/request_models/register_request.dart';
import 'package:test/test.dart';

void main() {
  test('to json', () {
    RegisterRequest request = RegisterRequest(
      "email",
      "password",
      firstName: "firstName",
      lastName: "lastName",
    );
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(json["email"], "email");
    expect(json["first_name"], "firstName");
    expect(json["last_name"], "lastName");
    expect(json["password"], "password");
  });
}
