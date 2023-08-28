import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/response_models/user_response.dart';
import 'package:client_common/api/user_api.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/oauth/oauth_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          var theme = LenraTheme.of(context);
          bool isMobileDevice = MediaQuery.of(context).size.width <= 875;

          return Scaffold(
            body: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 60, top: 60),
                          child: Image.asset(
                            'assets/images/logo-vertical.png',
                            height: theme.baseSize * 8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(100),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: theme.lenraTextThemeData.headline1,
                                text: "Welcome to the ",
                                children: [
                                  TextSpan(
                                      text: "technical platform",
                                      style: TextStyle(color: LenraColorThemeData.lenraBlue)),
                                  TextSpan(text: " !"),
                                ],
                              ),
                            ),
                            SizedBox(height: 32),
                            LenraButton(
                              onPressed: () async {
                                bool authenticated = await authenticate(context);
                                if (authenticated) {
                                  context.go(context.read<OAuthModel>().beforeRedirectPath);
                                }
                              },
                              text: 'Sign in to Lenra',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                isMobileDevice
                    ? SizedBox()
                    : Flexible(
                        child: Container(
                          constraints: BoxConstraints.expand(),
                          padding: EdgeInsets.all(32),
                          decoration: BoxDecoration(color: Color(0xFF1E232C)),
                          child: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: List.generate(
                                    37,
                                    (index) => Text(
                                      (index + 1).toString(),
                                      style: TextStyle(color: Color(0xFF475367), fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "module.exports = (data, counter) => {\n        return {\n                \"type\": \"flex\",\n                \"spacing\": 2, \n                \"mainAxisAlignment\": \n                \"spaceEvenly\", \n                \"crossAxisAlignment\": \n                \"center\", \n                \"children\": [ \n                        { \n                                \"type\": \"text\", \n                                \"value\": `\${counter.text}: \${data[0].count}` \n                        }, \n                        { \n                                \"type\": \"button\", \n                                \"text\": \"+\", \n                                \"onPressed\": { \n                                        \"action\": \"increment\", \n                                        \"props\": { \n                                                \"id\": data[0]._id, \n                                                \"datastore\": data[0].datastore \n                                        } \n                                } \n                        } \n                ] \n        }\n}",
                                      style: TextStyle(color: Color(0xFF70CBF2), fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
      return await authenticate(context);
    }

    return oauthModel.accessToken != null;
  }

  static Future<bool> authenticate(BuildContext context) async {
    AccessTokenResponse? response = await context.read<OAuthModel>().authenticate();
    if (response != null) {
      context.read<AuthModel>().accessToken = response;

      // Set the token for the global API instance
      LenraApi.instance.token = response.accessToken;

      if (context.read<AuthModel>().user == null) {
        UserResponse user = await UserApi.me();
        context.read<AuthModel>().user = user.user;
      }

      return true;
    }

    return false;
  }
}
