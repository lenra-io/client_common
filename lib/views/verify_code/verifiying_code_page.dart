import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:client_common/views/verify_code/verify_code_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyingCodePage extends StatelessWidget {
  static const routeName = '/code';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Thank you for your registration",
      message: "Great things are about to happen! We have sent you a registration code to access our platform.",
      child: VerifyCodeForm(),
      backInkText: "Logout",
      //For now, when registering, we don't have a refreshToken. So just delete accessToken/user and redirect to the login page.
      backInkAction: () => {
        context.read<AuthModel>().accessToken = null,
        context.read<AuthModel>().user = null,
        CommonNavigator.go(context, CommonNavigator.sign, extra: {"register": false})
      },
    );
  }
}
