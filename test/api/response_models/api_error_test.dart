import 'package:client_common/api/response_models/api_error.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"reason": "error", "error": "Message d'erreur"};
    ApiError error = ApiError.fromJson(json);
    expect(error.reason, "error");
    expect(error.message, "Message d'erreur");
  });
}
