import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:provider/provider.dart';

class InvitePage extends StatelessWidget {
  final String appName;
  final String uuid;

  const InvitePage({Key? key, required this.appName, required this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

    AuthModel authModel = context.read<AuthModel>();

    return SimplePage(
      child: LenraFlex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LenraText(text: "You are invited yo join the application : " + appName),
          LenraText(text: "You are logged with : " + authModel.user!.email),
          LenraText(text: "Would you accepot invitation ?"),
          LenraButton(text: "Accept", onPressed: () {}),
          RichText(
            text: TextSpan(
              text: "Change my account",
              style: finalLenraTextThemeData.blueBodyText,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  authModel.logout();
                },
            ),
          )
        ],
      ),
    );
  }
}
