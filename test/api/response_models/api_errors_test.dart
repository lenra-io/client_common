import 'package:client_common/api/response_models/api_errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';

void main() {
  test('from json', () {
    List<Map<String, dynamic>> json = [
      {"code": 42, "message": "Message d'erreur"},
      {"code": 1337, "message": "Message d'erreur 2"}
    ];
    ApiErrors errors = ApiErrors.fromJson(json);
    expect(errors.length, 2);
    expect(errors[0].code, 42);
    expect(errors[0].message, "Message d'erreur");
    expect(errors[1].code, 1337);
    expect(errors[1].message, "Message d'erreur 2");
  });
}
