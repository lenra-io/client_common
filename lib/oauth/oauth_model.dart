import 'dart:async';

import 'package:client_common/oauth/oauth.dart';
import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OAuthModel extends ChangeNotifier {
  AccessTokenResponse? accessToken;
  late OAuth2Helper helper;
  String beforeRedirectPath = "/";

  String clientId;
  String redirectUrl;
  List<String> scopes;

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
    accessToken = await helper.getToken();

    notifyListeners();

    return accessToken;
  }

  Future<void> logout() async {
    await Future.wait([helper.disconnect(), _oauthDisconnect()]);

    notifyListeners();
  }

  Future<void> _oauthDisconnect() async {
    const url =
        '${const String.fromEnvironment("OAUTH_BASE_URL", defaultValue: 'http://localhost:4444')}/oauth2/sessions/logout';

    var client = createHttpClient();
    await client.get(Uri.parse(url));
  }

  String getPlatformCustomUriScheme() {
    // It is important to check for web first because web is also returning the TargetPlatform of the device.
    if (kIsWeb) {
      return "http";
    } else if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
      // Apparently the customUriScheme should be the full uri for Windows and Linux for oauth2_client to work properly
      return const String.fromEnvironment("OAUTH_REDIRECT_BASE_URL", defaultValue: "http://localhost:10000");
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return "io.lenra.app";
    } else {
      return "http";
    }
  }
}
