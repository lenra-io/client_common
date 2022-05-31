import 'dart:convert';

import 'package:client_common/api/request_models/ask_code_lost_password_request.dart';
import 'package:test/test.dart';

void main() {
  test('to json', () {
    AskCodeLostPasswordRequest request = AskCodeLostPasswordRequest("email");
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(json["email"], "email");
  });
}
