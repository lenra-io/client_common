import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class ApiErrorSnackBar extends SnackBar {
  final ApiError error;
  final Function() onPressAction;
  final String actionLabel;

  ApiErrorSnackBar({required this.error, required this.onPressAction, required this.actionLabel})
      : super(
            duration: Duration(seconds: 10),
            backgroundColor: LenraColorThemeData.lenraCustomRed,
            content: Text(error.toString()),
            action: SnackBarAction(
              label: actionLabel,
              onPressed: onPressAction,
            ));

  static Widget formatError(ApiError error) {
    return LenraFlex(
      children: [Text("Error code: ${error.code}"), Text("Message: ${error.message}", textAlign: TextAlign.center)],
    );
  }
}
