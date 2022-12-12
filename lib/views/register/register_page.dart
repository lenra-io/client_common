import 'package:client_common/views/register/register_form.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      backInkText: "Back to the login page",
      backInkAction: () {
        GoRouter.of(context).pop();

        //GoRouter.of(context).go(CommonNavigator.loginRoute);
      },
      title: "Create your account",
      child: RegisterForm(),
    );
  }
}
