import 'package:client_common/api/request_models/api_request.dart';

class SendCodeLostPasswordRequest extends ApiRequest {
  final String code;
  final String email;
  final String password;
  final String passwordConfirmation;

  SendCodeLostPasswordRequest(this.code, this.email, this.password, this.passwordConfirmation);

  Map<String, String> toJson() => {
        'code': code,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}
