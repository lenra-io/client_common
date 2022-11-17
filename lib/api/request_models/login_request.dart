import 'package:client_common/api/request_models/api_request.dart';

class LoginRequest extends ApiRequest {
  final String email;
  final String password;
  final bool keep;

  LoginRequest(this.email, this.password, this.keep);

  Map<String, String> toJson() => {
        'email': email,
        'password': password,
        'keep': keep.toString(),
      };
}
