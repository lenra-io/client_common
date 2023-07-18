import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/oauth/oauth_model.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:provider/provider.dart';

class OAuthPage extends StatefulWidget {
  final Widget child;

  const OAuthPage({Key? key, required this.child}) : super(key: key);

  @override
  _OAuthPageState createState() => _OAuthPageState();
}

class _OAuthPageState extends State<OAuthPage> {
  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated(context)) {
      return SimplePage(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraButton(
              onPressed: () async {
                AccessTokenResponse? response = await context.read<OAuthModel>().authenticate();
                if (response != null) {
                  context.read<AuthModel>().accessToken = response;
                  // Set the token for the global API instance
                  LenraApi.instance.token = response.accessToken;

                  // TODO: Should i uncomment this code ?
                  // UserResponse user = await UserApi.me();
                  // context.read<AuthModel>().user = user.user;

                  setState(() {});
                }
              },
              text: 'Sign in to Lenra',
            )
          ],
        ),
      );
    } else {
      return widget.child;
    }
  }

  bool _isAuthenticated(BuildContext context) {
    OAuthModel oauthModel = context.read<OAuthModel>();
    // TODO: Is there a refresh feature on oauth2 ?

    return oauthModel.accessToken != null;
  }
}
