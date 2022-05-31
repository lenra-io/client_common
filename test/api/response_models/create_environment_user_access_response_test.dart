import 'package:client_common/api/response_models/create_environment_user_access_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "inserted_user_access": {"user_id": 1, "environment_id": 1}
    };
    CreateEnvironmentUserAccessResponse accessResponse = CreateEnvironmentUserAccessResponse.fromJson(json);
    expect(accessResponse.environmentUserAccessResponse.environmentId, 1);
    expect(accessResponse.environmentUserAccessResponse.userId, 1);
  });
}
