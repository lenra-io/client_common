import 'package:client_common/api/response_models/cgu_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"id": 1, "hash": "1234", "path": "/cgu/CGU_fr_1.html", "version": 1};
    CguResponse cguResponse = CguResponse.fromJson(json);
    expect(cguResponse.id, 1);
    expect(cguResponse.hash, "1234");
    expect(cguResponse.path, "/cgu/CGU_fr_1.html");
    expect(cguResponse.version, 1);
  });
}
