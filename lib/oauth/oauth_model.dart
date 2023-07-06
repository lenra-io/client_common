import 'dart:async';

import 'package:client_common/oauth/oauth.dart';
import 'package:flutter/widgets.dart';
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
        customUriScheme: "http",
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
}
