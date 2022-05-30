import 'package:client_common/api/request_models/api_request.dart';

class RegisterRequest extends ApiRequest {
  final String email;
  final String? firstName;
  final String? lastName;
  final String password;

  RegisterRequest(this.email, this.password, {this.firstName, this.lastName});

  Map<String, String> toJson() => {
        'email': email,
        if (firstName != null) 'first_name': firstName!,
        if (lastName != null) 'last_name': lastName!,
        'password': password,
      };
}
