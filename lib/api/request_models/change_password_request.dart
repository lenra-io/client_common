import 'package:client_common/api/request_models/api_request.dart';

class ChangePasswordRequest extends ApiRequest {
  final String oldPassword;
  final String password;
  final String passwordConfirmation;

  ChangePasswordRequest(this.oldPassword, this.password, this.passwordConfirmation);

  Map<String, String> toJson() => {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}
