import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/environment_user_accesses_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "environment_user_accesses": [
        {"user_id": 1, "environment_id": 1},
        {"user_id": 2, "environment_id": 1}
      ]
    };
    EnvironmentUserAccessesResponse accessResponse = EnvironmentUserAccessesResponse.fromJson(json);
    expect(accessResponse.accesses.length, 2);
    expect(accessResponse.accesses.first.environmentId, 1);
    expect(accessResponse.accesses.first.userId, 1);
    expect(accessResponse.accesses[1].environmentId, 1);
    expect(accessResponse.accesses[1].userId, 2);
  });
}
