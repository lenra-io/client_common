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
  OAuthPageState createState() => OAuthPageState();
}

class OAuthPageState extends State<OAuthPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isAuthenticated(context),
      builder: ((context, snapshot) {
        if (!(snapshot.data ?? false)) {
          return SimplePage(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LenraButton(
                  onPressed: () async {
                    await authenticate();
                    setState(() {});
                  },
                  text: 'Sign in to Lenra',
                )
              ],
            ),
          );
        } else {
          return widget.child;
        }
      }),
    );
  }

  Future<bool> _isAuthenticated(BuildContext context) async {
    OAuthModel oauthModel = context.read<OAuthModel>();
    // TODO: Is there a refresh feature on oauth2 ?

    AccessTokenResponse? token = await oauthModel.helper.getTokenFromStorage();
    print("GET TOKEN FROM STORAGE");
    print(token?.accessToken);
    if (token?.accessToken != null) {
      return await authenticate();
    }

    return oauthModel.accessToken != null;
  }

  Future<bool> authenticate() async {
    print("AUTHENTICATING FROM OAUTH PAGE");
    AccessTokenResponse? response = await context.read<OAuthModel>().authenticate();
    print("GOT TOKEN: ${response}");
    if (response != null) {
      context.read<AuthModel>().accessToken = response;
      print(response.accessToken);
      // Set the token for the global API instance
      LenraApi.instance.token = response.accessToken;

      // TODO: Should i uncomment this code ?
      // UserResponse user = await UserApi.me();
      // context.read<AuthModel>().user = user.user;
      return true;
    }

    return false;
  }
}
