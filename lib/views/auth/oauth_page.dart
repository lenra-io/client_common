import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/response_models/user_response.dart';
import 'package:client_common/api/user_api.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/oauth/oauth_model.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:provider/provider.dart';

class OAuthPage extends StatefulWidget {
  const OAuthPage({Key? key}) : super(key: key);

  @override
  OAuthPageState createState() => OAuthPageState();
}

class OAuthPageState extends State<OAuthPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(context),
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
                    await authenticate(context);
                    setState(() {});
                  },
                  text: 'Sign in to Lenra',
                )
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  static Future<bool> isAuthenticated(BuildContext context) async {
    OAuthModel oauthModel = context.read<OAuthModel>();

    AccessTokenResponse? token = await oauthModel.helper.getTokenFromStorage();
    if (token?.accessToken != null) {
      print("Found token in storage");
      return await authenticate(context);
    }

    return oauthModel.accessToken != null;
  }

  static Future<bool> authenticate(BuildContext context) async {
    AccessTokenResponse? response = await context.read<OAuthModel>().authenticate();
    if (response != null) {
      print("Authenticated with token: ${response.accessToken}");
      context.read<AuthModel>().accessToken = response;

      // Set the token for the global API instance
      LenraApi.instance.token = response.accessToken;

      if (context.read<AuthModel>().user == null) {
        print("Fetching user");
        UserResponse user = await UserApi.me();
        context.read<AuthModel>().user = user.user;
        print("Fetched user: ${user.user}");
      }

      return true;
    }

    return false;
  }
}
