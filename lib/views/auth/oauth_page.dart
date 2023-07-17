import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/response_models/cgu_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/models/cgu_model.dart';
import 'package:client_common/oauth/oauth_model.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:provider/provider.dart';

class OAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

                // UserResponse user = await UserApi.me();
                // context.read<AuthModel>().user = user.user;

                CguModel cguModel = context.read<CguModel>();

                // Accept latest CGU if not already accepted
                // This is done by default when the user registers as long as the oauth does not implement it
                // TODO: Implement oauth cgu acceptance
                print('ACCEPTING CGU MANUALLY FOR THE MOMENT');
                if (!(await cguModel.userAcceptedLatestCgu()).accepted) {
                  CguResponse latestCGUResponse = await cguModel.getLatestCgu();
                  await cguModel.acceptCgu(latestCGUResponse.id);
                }

                AuthModel authModel = context.read<AuthModel>();

                // TODO: Implement oauth role validation?
                print('SETTING USER ROLE TO DEV MANUALLY FOR THE MOMENT');
                if (!authModel.isOneOfRole([UserRole.admin, UserRole.dev])) {
                  authModel.validateDev();
                }

                GoRouter.of(context).go(authModel.redirectToRoute ?? '/');
              }
            },
            text: 'Sign in to Lenra',
          )
        ],
      ),
    );
  }
}
