import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/user_accept_cgu_version_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "accepted_cgu": {"user_id": 1, "cgu_id": 1}
    };
    UserAcceptCguVersionResponse response = UserAcceptCguVersionResponse.fromJson(json);
    expect(response.userId, 1);
    expect(response.cguId, 1);
  });
}
