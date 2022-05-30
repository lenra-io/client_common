import 'package:client_common/api/response_models/api_errors.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class ApiErrorSnackBar extends SnackBar {
  final ApiErrors errors;
  final Function() onPressAction;
  final String actionLabel;

  ApiErrorSnackBar({required this.errors, required this.onPressAction, required this.actionLabel})
      : super(
            duration: Duration(seconds: 10),
            backgroundColor: LenraColorThemeData.lenraCustomRed,
            content: Text(errors.toString()),
            action: SnackBarAction(
              label: actionLabel,
              onPressed: onPressAction,
            ));

  static List<Widget> formatErrors(ApiErrors errors) {
    return errors
        .map((error) => LenraFlex(
              children: [
                Text("Error code: ${error.code}"),
                Text("Message: ${error.message}", textAlign: TextAlign.center)
              ],
            ))
        .toList();
  }
}
