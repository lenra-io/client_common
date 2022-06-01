import 'package:client_common/views/profile/change_password_form.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text("Profile"),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Text("Change my password"),
                  Container(
                    child: ChangePasswordForm(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
