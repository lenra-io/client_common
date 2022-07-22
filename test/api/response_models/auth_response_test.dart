import 'package:client_common/api/response_models/auth_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:test/test.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "id": 1,
      "first_name": "John",
      "last_name": "Doe",
      "role": "user",
      "email": "john@doe.com",
    };

    Map<String, String> headers = {"access_token": "myaccesstoken.truc.machin"};

    AuthResponse authResponse = AuthResponse.fromJson(json, headers);
    expect(authResponse.accessToken, "myaccesstoken.truc.machin");
    expect(authResponse.user.id, 1);
    expect(authResponse.user.email, "john@doe.com");
    expect(authResponse.user.firstName, "John");
    expect(authResponse.user.lastName, "Doe");
    expect(authResponse.user.role, UserRole.user);
  });
}
