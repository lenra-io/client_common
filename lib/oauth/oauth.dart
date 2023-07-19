import 'package:oauth2_client/oauth2_client.dart';

class LenraOAuth2Client extends OAuth2Client {
  LenraOAuth2Client({required String redirectUri, required String customUriScheme})
      : super(
          authorizeUrl:
              '${const String.fromEnvironment("OAUTH_BASE_URL", defaultValue: 'http://localhost:4444')}/oauth2/auth',
          tokenUrl:
              '${const String.fromEnvironment("OAUTH_BASE_URL", defaultValue: 'http://localhost:4444')}/oauth2/token',
          revokeUrl:
              '${const String.fromEnvironment("OAUTH_BASE_URL", defaultValue: 'http://localhost:4444')}/oauth2/revoke',
          redirectUri: redirectUri,
          customUriScheme: customUriScheme,
        );
}
