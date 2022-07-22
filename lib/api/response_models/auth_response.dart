import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/user.dart';

class AuthResponse extends ApiResponse {
  String accessToken;
  User user;

  AuthResponse.fromJson(Map<String, dynamic> json, Map<String, String> headers)
      : accessToken = headers["access_token"]!,
        user = User.fromJson(json);
}
