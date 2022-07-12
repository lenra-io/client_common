import 'package:client_common/api/response_models/user_accept_cgu_version_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"user_id": 1, "cgu_id": 1};
    UserAcceptCguVersionResponse response = UserAcceptCguVersionResponse.fromJson(json);
    expect(response.userId, 1);
    expect(response.cguId, 1);
  });
}
