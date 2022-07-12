import 'package:client_common/api/response_models/environments_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    List<Map<String, dynamic>> json = [
      {
        "id": 1,
        "name": "live",
        "is_ephemeral": false,
        "is_public": true,
        "application_id": 1,
        "creator_id": 1,
        "deployed_build_id": null
      }
    ];

    EnvironmentsResponse envsResponse = EnvironmentsResponse.fromJson(json);
    expect(envsResponse.envs.length, 1);
    var env = envsResponse.envs.first;
    expect(env.id, 1);
    expect(env.name, "live");
    expect(env.isEphemeral, false);
    expect(env.isPublic, true);
  });
}
