import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/cgu_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"id": 1, "hash": "1234", "link": "/cgu/cgu-1.0.0.html", "version": "1.0.0"};
    CguResponse cguResponse = CguResponse.fromJson(json);
    expect(cguResponse.id, 1);
    expect(cguResponse.hash, "1234");
    expect(cguResponse.link, "/cgu/cgu-1.0.0.html");
    expect(cguResponse.version, "1.0.0");
  });
}
