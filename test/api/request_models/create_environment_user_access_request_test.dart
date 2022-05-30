import 'dart:convert';

import 'package:client_common/api/request_models/create_environment_user_access_request.dart';
import 'package:test/test.dart';

void main() {
  test('to json', () {
    CreateEnvironmentUserAccessRequest request = CreateEnvironmentUserAccessRequest(userId: 1);
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(json["user_id"], 1);
  });
}
