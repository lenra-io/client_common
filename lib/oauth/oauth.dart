import 'package:client_common/config/config.dart';
import 'package:oauth2_client/oauth2_client.dart';

class LenraOAuth2Client extends OAuth2Client {
  LenraOAuth2Client({required String redirectUri, required String customUriScheme})
      : super(
          authorizeUrl: '${Config.instance.oauthBaseUrl}/oauth2/auth',
          tokenUrl: '${Config.instance.oauthBaseUrl}/oauth2/token',
          revokeUrl: '${Config.instance.oauthBaseUrl}/oauth2/revoke',
          redirectUri: redirectUri,
          customUriScheme: customUriScheme,
        );
}
