import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/register/register_form.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      backInkText: "Back to the login page",
      backInkAction: () {
        CommonNavigator.pop(context);
      },
      title: "Create your account",
      child: RegisterForm(),
    );
  }
}
