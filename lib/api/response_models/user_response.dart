import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/user.dart';

class UserResponse extends ApiResponse {
  User? user;

  UserResponse.fromJson(Map<String, dynamic>? json, Map<String, String> headers) : user = json == null ? null : User.fromJson(json);
}
