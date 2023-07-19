import 'dart:async';

import 'package:client_common/oauth/oauth.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OAuthModel extends ChangeNotifier {
  AccessTokenResponse? accessToken;

  String clientId;
  String redirectUrl;
  List<String> scopes;

  OAuthModel(this.clientId, this.redirectUrl, {this.scopes = const []}) : super();

  Future<AccessTokenResponse?> authenticate() async {
    Completer<AccessTokenResponse?> completer = Completer();

    OAuth2Helper oauth2Helper = OAuth2Helper(
      LenraOAuth2Client(
        redirectUri: redirectUrl,
        // TODO: On Windows/Linux it should be set to `http://localhost:{port}`
        // TODO: On web it should be `http`
        // TODO: On Android i don't know what is the best solution, it seems that `http` is working properly
        customUriScheme: getPlatformCustomUriScheme(),

        // "http",
      ),
      grantType: OAuth2Helper.authorizationCode,
      clientId: clientId,
      scopes: scopes,
    );

    accessToken = await oauth2Helper.getToken();
    completer.complete(accessToken);
    notifyListeners();

    return completer.future;
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
