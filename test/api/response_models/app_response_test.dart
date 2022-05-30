import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"id": 1, "name": "myapp", "icon": 60184, "color": "FFFFFF", "service_name": "service"};
    AppResponse appResponse = AppResponse.fromJson(json);
    expect(appResponse.name, "myapp");
  });
}
