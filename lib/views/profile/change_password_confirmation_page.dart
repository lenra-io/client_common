import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class ChangePasswordConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Your new password has been successfully saved!",
      child: SizedBox(
        width: double.infinity,
        child: LenraButton(
          text: "Continue on Lenra",
          onPressed: () {
            Navigator.pushNamed(context, CommonNavigator.homeRoute);
          },
        ),
      ),
    );
  }
}
