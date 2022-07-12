import 'package:client_common/api/response_models/update_environment_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "id": 1,
      "name": "live",
      "is_ephemeral": false,
      "is_public": true,
      "application_id": 1,
      "creator_id": 1,
      "deployed_build_id": null
    };

    UpdateEnvironmentResponse updateEnvResponse = UpdateEnvironmentResponse.fromJson(json);

    var env = updateEnvResponse.environmentResponse;
    expect(env.id, 1);
    expect(env.name, "live");
    expect(env.isEphemeral, false);
    expect(env.isPublic, true);
  });
}
