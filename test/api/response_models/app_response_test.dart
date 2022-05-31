import 'package:client_common/api/response_models/app_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"id": 1, "name": "myapp", "icon": 60184, "color": "FFFFFF", "service_name": "service"};
    AppResponse appResponse = AppResponse.fromJson(json);
    expect(appResponse.name, "myapp");
  });
}
