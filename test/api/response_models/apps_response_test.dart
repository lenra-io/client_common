import 'package:client_common/api/response_models/apps_response.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "apps": [
        {"id": 1, "name": "counter-new", "icon": 60184, "color": "FFFFFF", "service_name": "service1"},
        {"id": 2, "name": "helloworld", "icon": 60185, "color": "FFFFFF", "service_name": "service2"}
      ]
    };
    AppsResponse appsResponse = AppsResponse.fromJson(json);
    expect(appsResponse.apps.length, 2);
    expect(appsResponse.apps[0].name, "counter-new");
    expect(appsResponse.apps[1].name, "helloworld");
  });
}
