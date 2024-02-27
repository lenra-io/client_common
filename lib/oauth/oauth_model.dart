import 'dart:async';

import 'package:client_common/api/request_models/ask_code_lost_password_request.dart';
import 'package:client_common/api/request_models/change_password_request.dart';
import 'package:client_common/api/request_models/send_code_lost_password_request.dart';
import 'package:client_common/api/request_models/validate_dev_request.dart';
import 'package:client_common/api/response_models/empty_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/api/response_models/user_response.dart';
import 'package:client_common/api/user_api.dart';
import 'package:client_common/config/config.dart';
import 'package:client_common/models/status.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/oauth/oauth.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class OAuthModel extends ChangeNotifier {
  late OAuth2Helper helper;
  String beforeRedirectPath = "/";

  String clientId;
  String redirectUrl;
  List<String> scopes;

  User? user;

  final Status<UserResponse> refreshStatus = Status();
  final Status<UserResponse> validateUserStatus = Status();
  final Status<EmptyResponse> resendRegistrationTokenStatus = Status();
  final Status<UserResponse> validateDevStatus = Status();

  final Status<EmptyResponse> logoutStatus = Status();

  final Status<EmptyResponse> askCodeLostPasswordStatus = Status();
  final Status<EmptyResponse> sendCodeLostPasswordStatus = Status();
  final Status<EmptyResponse> changePasswordStatus = Status();

  /// The route to redirect to after the user has logged in or out.
  String? redirectToRoute;

  OAuthModel(this.clientId, this.redirectUrl, {this.scopes = const []}) {
    helper = OAuth2Helper(
      LenraOAuth2Client(
        redirectUri: redirectUrl,
        customUriScheme: getPlatformCustomUriScheme(),
      ),
      grantType: OAuth2Helper.authorizationCode,
      clientId: clientId,
      scopes: scopes,
    );
  }

  Future<AccessTokenResponse?> authenticate() async {
    return await helper.getToken();
  }

  Future<void> logout() async {
    await Future.wait([helper.disconnect(), _oauthDisconnect()]);

    notifyListeners();
  }

  Future<void> _oauthDisconnect() async {
    String urlStr = '${Config.instance.oauthBaseUrl}/oauth2/sessions/logout';
    var uri = Uri.parse(urlStr);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch $urlStr";
    }
  }

  String getPlatformCustomUriScheme() {
    // It is important to check for web first because web is also returning the TargetPlatform of the device.
    if (kIsWeb) {
      return "http";
    } else if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
      // Apparently the customUriScheme should be the full uri for Windows and Linux for oauth2_client to work properly
      return const String.fromEnvironment("OAUTH_REDIRECT_BASE_URL", defaultValue: "http://localhost:10000");
    } else if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      return "io.lenra.app";
    } else {
      return "http";
    }
  }

  bool isOneOfRole(List<UserRole> roles) {
    if (user == null) return false;
    return roles.contains(user?.role);
  }

  Future<UserResponse> validateDev() async {
    var res = await validateDevStatus.handle(() => UserApi.validateDev(ValidateDevRequest()), notifyListeners);
    user = res.user;
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
