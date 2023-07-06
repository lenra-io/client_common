import 'dart:async';

import 'package:client_common/oauth/oauth.dart';
import 'package:flutter/widgets.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OAuthModel extends ChangeNotifier {
  AccessTokenResponse? accessToken;

  Future<AccessTokenResponse?> authenticate() async {
    Completer<AccessTokenResponse?> completer = Completer();

    OAuth2Helper oauth2Helper = OAuth2Helper(
      LenraOAuth2Client(
        redirectUri: "http://localhost:10000/redirect.html",
        customUriScheme: "http",
      ),
      grantType: OAuth2Helper.authorizationCode,
      clientId: 'e1773e26-644f-4083-9941-a5406525819d',
      scopes: ['email', 'public'],
    );

    accessToken = await oauth2Helper.getToken();
    completer.complete(accessToken);
    notifyListeners();

    return completer.future;
  }
}
