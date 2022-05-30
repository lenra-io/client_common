import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/environment_user_access_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"user_id": 1, "environment_id": 1};
    EnvironmentUserAccessResponse accessResponse = EnvironmentUserAccessResponse.fromJson(json);
    expect(accessResponse.environmentId, 1);
    expect(accessResponse.userId, 1);
  });
}
