import 'package:client_common/api/response_models/environment_user_access_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"user_id": 1, "environment_id": 1};
    EnvironmentUserAccessResponse accessResponse = EnvironmentUserAccessResponse.fromJson(json);
    expect(accessResponse.environmentId, 1);
    expect(accessResponse.userId, 1);
  });
}
