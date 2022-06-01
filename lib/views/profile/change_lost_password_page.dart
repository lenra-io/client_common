import 'package:client_common/views/login/change_lost_password_form.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';

class ChangeLostPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? email = ModalRoute.of(context)?.settings.arguments as String?;
    return SimplePage(
      title: "Reset your account password",
      child: ChangeLostPasswordForm(email: email),
    );
  }
}
