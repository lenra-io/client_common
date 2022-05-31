import 'package:client_common/api/response_models/environment_response.dart';
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

    EnvironmentResponse environmentResponse = EnvironmentResponse.fromJson(json);
    expect(environmentResponse.id, 1);
    expect(environmentResponse.name, "live");
    expect(environmentResponse.isEphemeral, false);
    expect(environmentResponse.isPublic, true);
  });
}
