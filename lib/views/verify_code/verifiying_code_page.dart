import 'package:client_common/views/simple_page.dart';
import 'package:client_common/views/verify_code/verify_code_form.dart';
import 'package:flutter/material.dart';

class VerifyingCodePage extends StatelessWidget {
  static const routeName = '/code';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Thank you for your registration",
      message: "Great things are about to happen! We have sent you a token to access our platform.",
      child: VerifyCodeForm(),
    );
  }
}
