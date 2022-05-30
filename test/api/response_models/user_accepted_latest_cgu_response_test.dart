import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/user_accepted_latest_cgu_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"user_accepted_latest_cgu": true};
    UserAcceptedLatestCguResponse acceptedLatestResponse = UserAcceptedLatestCguResponse.fromJson(json);
    expect(acceptedLatestResponse.accepted, true);
  });
}
