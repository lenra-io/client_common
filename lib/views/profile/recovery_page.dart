import 'package:client_common/views/login/recovery_form.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Did you lose your password ? Don't worry, it happens even to the best!",
      backInkText: "Back to the login page",
      backInkAction: () {
        GoRouter.of(context).pop();
      },
      child: RecoveryForm(),
    );
  }
}
