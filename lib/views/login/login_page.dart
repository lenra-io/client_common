import 'package:client_common/views/login/login_form.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      child: LoginForm(),
    );
  }
}
