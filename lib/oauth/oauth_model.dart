import 'dart:async';

import 'package:client_common/oauth/oauth.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OAuthModel extends ChangeNotifier {
  AccessTokenResponse? accessToken;
  late OAuth2Helper helper;

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

  String getPlatformCustomUriScheme() {
    // It is important to check for web first because web is also returning the TargetPlatform of the device.
    if (kIsWeb) {
      return "http";
    } else if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
      return const String.fromEnvironment("OAUTH_REDIRECT_BASE_URL", defaultValue: "http://localhost:10000");
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return "io.lenra.app";
    } else {
      return "http";
    }
  }
}
