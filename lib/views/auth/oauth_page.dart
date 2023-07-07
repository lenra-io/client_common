import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/response_models/user_response.dart';
import 'package:client_common/api/user_api.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/oauth/oauth_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:provider/provider.dart';

class OAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            AccessTokenResponse? response = await context.read<OAuthModel>().authenticate();
            if (response != null) {
              context.read<AuthModel>().accessToken = response;
              // Set the token for the global API instance
              LenraApi.instance.token = response.accessToken;

              UserResponse user = await UserApi.me();
              context.read<AuthModel>().user = user.user;

              GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
            }
          },
          child: Text('Sign in to Lenra'),
        )
      ],
    );
  }
}
