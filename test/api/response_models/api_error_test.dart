import 'package:client_common/api/response_models/api_error.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"code": 42, "message": "Message d'erreur"};
    ApiError error = ApiError.fromJson(json);
    expect(error.code, 42);
    expect(error.message, "Message d'erreur");
  });
}
