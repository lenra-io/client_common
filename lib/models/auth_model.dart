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
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/api/user_api.dart';
import 'package:client_common/models/status.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:flutter/material.dart';

/// The model that manages the authentication of the user.
class AuthModel extends ChangeNotifier {
  /// The access token of the user.
  String? accessToken;
  User? user;
  final Status<AuthResponse> registerStatus = Status();
  final Status<AuthResponse> loginStatus = Status();
  final Status<AuthResponse> refreshStatus = Status();
  final Status<AuthResponse> validateUserStatus = Status();
  final Status<AuthResponse> validateDevStatus = Status();

  final Status<EmptyResponse> logoutStatus = Status();

  final Status<EmptyResponse> askCodeLostPasswordStatus = Status();
  final Status<EmptyResponse> sendCodeLostPasswordStatus = Status();
  final Status<EmptyResponse> changePasswordStatus = Status();

  /// The route to redirect to after the user has logged in or out.
  String? redirectToRoute;

  /// The user is authenticated if his access token is set.
  bool isAuthenticated() {
    return accessToken != null && user != null;
  }

  bool isOneOfRole(List<UserRole> roles) {
    if (user == null) return false;
    return roles.contains(user?.role);
  }

  /// Handle the response of authentication requests.
  AuthResponse _handleAuthResponse(AuthResponse res) {
    accessToken = res.accessToken;
    // Set the token for the global API instance
    LenraApi.instance.token = accessToken;
    user = res.user;
    return res;
  }

  Future<AuthResponse> register(String email, String password) async {
    var res = await registerStatus.handle(() => UserApi.register(RegisterRequest(email, password)), notifyListeners);
    _handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> login(String email, String password) async {
    var res = await loginStatus.handle(() => UserApi.login(LoginRequest(email, password)), notifyListeners);
    _handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> refresh() async {
    var res = await refreshStatus.handle(UserApi.refresh, notifyListeners);
    _handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> validateUser(String code) async {
    var res = await validateUserStatus.handle(() => UserApi.validateUser(ValidateUserRequest(code)), notifyListeners);
    _handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> validateDev(String code) async {
    var res = await validateDevStatus.handle(() => UserApi.validateDev(ValidateDevRequest(code)), notifyListeners);
    _handleAuthResponse(res);
    return res;
  }

  Future<EmptyResponse> logout() async {
    var res = await logoutStatus.handle(UserApi.logout, notifyListeners);
    accessToken = null;
    user = null;
    notifyListeners();
    return res;
  }

  Future<EmptyResponse> askCodeLostPassword(String email) async {
    var res = await askCodeLostPasswordStatus.handle(
        () => UserApi.askCodeLostPassword(AskCodeLostPasswordRequest(email)), notifyListeners);
    notifyListeners();
    return res;
  }

  Future<EmptyResponse> sendCodeLostPassword(String code, String email, String password, String confirmation) async {
    var res = await sendCodeLostPasswordStatus.handle(
        () => UserApi.sendCodeLostPassword(SendCodeLostPasswordRequest(code, email, password, confirmation)),
        notifyListeners);
    notifyListeners();
    return res;
  }

  Future<EmptyResponse> changePassword(String old, String password, String confirmation) async {
    var res = await changePasswordStatus.handle(
        () => UserApi.changePassword(ChangePasswordRequest(old, password, confirmation)), notifyListeners);
    notifyListeners();
    return res;
  }

  String getRedirectionRouteAfterAuthentication() {
    return redirectToRoute ?? CommonNavigator.homeRoute;
  }
}
