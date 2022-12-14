import 'package:client_common/views/login/change_lost_password_form.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';

class ChangeLostPasswordPage extends StatelessWidget {
  final String email;
  ChangeLostPasswordPage({required this.email});
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Reset your account password",
      child: ChangeLostPasswordForm(email: email),
    );
  }
}
