import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/ask_code_lost_password_request.dart';
import 'package:client_common/api/request_models/change_password_request.dart';
import 'package:client_common/api/request_models/login_request.dart';
import 'package:client_common/api/request_models/register_request.dart';
import 'package:client_common/api/request_models/send_code_lost_password_request.dart';
import 'package:client_common/api/request_models/validate_dev_request.dart';
import 'package:client_common/api/request_models/validate_user_request.dart';
import 'package:client_common/api/response_models/auth_response.dart';
import 'package:client_common/api/response_models/empty_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// All of the user requests that can be done on Lenra.
class UserApi {
  static Future<AuthResponse> register(RegisterRequest body) => LenraAuth.instance.post(
        "/register",
        body: body,
        responseMapper: (json, headers) => AuthResponse.fromJson(json, headers),
      );

  static Future<AuthResponse> login(LoginRequest body) => LenraAuth.instance.post(
        "/login",
        body: body,
        responseMapper: (json, headers) => AuthResponse.fromJson(json, headers),
      );

  static Future<AuthResponse> validateUser(ValidateUserRequest body) => LenraApi.instance.post(
        "/verify",
        body: body,
        responseMapper: (json, headers) => AuthResponse.fromJson(json, headers),
      );

  static Future<EmptyResponse> resendRegistrationToken() => LenraApi.instance.post(
        "/verify/lost",
        responseMapper: (json, headers) => EmptyResponse.fromJson(json),
      );

  static Future<AuthResponse> validateDev(ValidateDevRequest body) => LenraApi.instance.put(
        "/verify/dev",
        body: body,
        responseMapper: (json, headers) => AuthResponse.fromJson(json, headers),
      );

  static Future<AuthResponse> refresh() async {
    Map<String, String>? headers;
    if (!kIsWeb) {
      final storage = FlutterSecureStorage();

      String? refreshToken = await storage.read(key: "refreshToken");
      print("REFRESH REQUEST");
      print(refreshToken);
      if (refreshToken != null) {
        headers = {"guardian_default_token": refreshToken};
      }
    }

    return LenraAuth.instance.post(
      "/refresh",
      responseMapper: (json, headers) => AuthResponse.fromJson(json, headers),
      headers: headers,
    );
  }

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
