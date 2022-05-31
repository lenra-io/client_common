import 'dart:convert';

import 'package:client_common/api/request_models/update_environment_request.dart';
import 'package:test/test.dart';

void main() {
  test('to json', () {
    UpdateEnvironmentRequest request = UpdateEnvironmentRequest(isPublic: true);
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(json["is_public"], true);
    expect(json.containsKey("name"), false);
    expect(json.containsKey("is_ephemeral"), false);
  });
}
