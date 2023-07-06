import 'package:oauth2_client/oauth2_client.dart';

class LenraOAuth2Client extends OAuth2Client {
  LenraOAuth2Client({required String redirectUri, required String customUriScheme})
      : super(
          authorizeUrl: 'http://localhost:4444/oauth2/auth',
          tokenUrl: 'http://localhost:4444/oauth2/token',
          revokeUrl: 'http://localhost:4444/oauth2/revoke',
          redirectUri: redirectUri,
          customUriScheme: customUriScheme,
        );
}
