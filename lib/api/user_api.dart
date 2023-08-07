import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/ask_code_lost_password_request.dart';
import 'package:client_common/api/request_models/change_password_request.dart';
import 'package:client_common/api/request_models/send_code_lost_password_request.dart';
import 'package:client_common/api/request_models/validate_dev_request.dart';
import 'package:client_common/api/response_models/auth_response.dart';
import 'package:client_common/api/response_models/empty_response.dart';
import 'package:client_common/api/response_models/user_response.dart';

/// All of the user requests that can be done on Lenra.
class UserApi {
  static Future<UserResponse> me() => LenraApi.instance.get(
        "/me",
        responseMapper: (json, headers) => UserResponse.fromJson(json, headers),
      );

  static Future<AuthResponse> validateDev(ValidateDevRequest body) => LenraApi.instance.put(
        "/verify/dev",
        body: body,
        responseMapper: (json, headers) => AuthResponse.fromJson(json, headers),
      );

  static Future<EmptyResponse> logout() => LenraAuth.instance.post(
        "/logout",
        responseMapper: (json, headers) => EmptyResponse.fromJson(json),
      );
  static Future<EmptyResponse> changePassword(ChangePasswordRequest body) => LenraApi.instance.put(
        "/password",
        body: body,
        responseMapper: (json, headers) => EmptyResponse.fromJson(json),
      );

  static Future<EmptyResponse> askCodeLostPassword(AskCodeLostPasswordRequest body) => LenraAuth.instance.post(
        "/password/lost",
        body: body,
        responseMapper: (json, headers) => EmptyResponse.fromJson(json),
      );

  static Future<EmptyResponse> sendCodeLostPassword(SendCodeLostPasswordRequest body) => LenraAuth.instance.put(
        "/password/lost",
        body: body,
        responseMapper: (json, headers) => EmptyResponse.fromJson(json),
      );
}
