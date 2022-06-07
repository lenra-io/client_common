import 'package:client_common/api/request_models/api_request.dart';

class LoginRequest extends ApiRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  Map<String, String> toJson() => {
        'email': email,
        'password': password,
      };
}
