/* 
According to the oauth2 library for Flutter (https://pub.dev/packages/oauth2)
we will need the following variables to make this work.

- The authorization endpoint to start the authorization flow 
  (auth-server.com/authorize)
- The token endpoint to generate an access token ? 
  (auth-server.com/token)
- The client ID which will be issued by the server to the client
- The client secret which will also be issued by the server
- The redirect url
- The credentials file ??? This could be replaced by any other storage solution
  Such as session storage

Then we can handle the connection :
1.  Get the credentials from the local storage if they exist
    If not, ask the server for new credentials by calling
    AuthorizationCodeGrant(
      identifier,
      authorizationEndpoint,
      tokenEndpoint,
      secret: secret
    )
2.  You can get the authorization url from the returned grant
    grant.getAuthorizationUrl(redirectUrl)
3.  Call the redirect method with the authorizationUrl
4.  Listen to ??? with the redirectUrl to get the responseUrl
5.  Call the handleAuthorizationResponse(
      responseUrl.queryParameters
    )
    To validate the queryParameters and extract the authorization code
    This will give a client in return that can be used accross the code
    to execute authenticated requests
6.  Once you have done all that, you can use the client to execute queries on
    the server.

Here are more precisions on the way to "redirect" and "listen"

redirect: 
  There is two ways of doing it, the first is to open a browser with the 
  url_launcher library. This will open the oauth page.
  The second is to open a webview. The problem of this solution is that it does
  not support desktop platforms for the moment.

listen:
  There is also two ways of doing it.
  The first is to listen for a redirect with the uni_links lib.
  getLinksStream().listen((uri){})
  and check that the uri is the same as the redirectUrl

  The second is to use the webview's functionnality with the navigationDelegate
  parameter that listens for redirections the same way as the 
  getLinksStream.listen() method.

After some discussion with the team, we will use url_launcher for all platforms
for the moment as webview seems to not be properly handled by Hydra. This
might need some more research to confirm.

The oauth2 library is handling PKCE by default. If you do not provide a 
code_verifier it will automatically generate one when instantiating a 
AuthorizationCodeGrant. It will also generate a code_challenge when calling
getAuthorizationUrl.
*/

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:oauth2/oauth2.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class LenraOauth extends ChangeNotifier {
  Client? client;

  void createClient(
    String identifier,
    Uri authorizationEndpoint,
    Uri tokenEndpoint,
    Uri redirectUrl,
    String? secret,
  ) async {
    // TODO: Fetch credentials from storage

    AuthorizationCodeGrant grant = AuthorizationCodeGrant(
      identifier,
      authorizationEndpoint,
      tokenEndpoint,
      secret: secret,
    );

    Uri authorizationUrl = grant.getAuthorizationUrl(redirectUrl);

    redirect(authorizationUrl);

    Uri responseUrl = await listen(redirectUrl);

    client = await grant.handleAuthorizationResponse(responseUrl.queryParameters);
    // TODO: notifyListeners() ??
  }

  void redirect(Uri authorizationUrl) async {
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    }
  }

  Future<Uri> listen(Uri redirectUrl) async {
    Completer<Uri> completer = Completer<Uri>();

    linkStream.listen((String? uri) async {
      if (uri != null && uri.startsWith(redirectUrl.toString())) {
        completer.complete(Uri.parse(uri));
      }
    });

    return completer.future;
  }
}
