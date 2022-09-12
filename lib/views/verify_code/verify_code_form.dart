import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/error.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class VerifyCodeForm extends StatefulWidget {
  @override
  State<VerifyCodeForm> createState() {
    return _VerifyCodeFormState();
  }
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  final logger = Logger("VerifyCodeForm");
  String code = "";

  @override
  Widget build(BuildContext context) {
    ApiError? validateUserError = context.select<AuthModel, ApiError?>((m) => m.validateUserStatus.error);
    bool hasError = context.select<AuthModel, bool>((m) => m.validateUserStatus.hasError());
    bool isLoading = context.select<AuthModel, bool>((m) => m.validateUserStatus.isFetching());

    return LenraFlex(
      direction: Axis.vertical,
      spacing: 32,
      children: [
        LenraFlex(
          direction: Axis.vertical,
          spacing: 16,
          children: [
            LenraFlex(
              spacing: 16,
              fillParent: true,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: LenraTextField(
                    hintText: "Token",
                    size: LenraComponentSize.large,
                    onChanged: (String value) {
                      code = value;
                    },
                    onSubmitted: (_) {
                      submit();
                    },
                  ),
                ),
                LenraButton(
                  text: "Confirm the token",
                  size: LenraComponentSize.medium,
                  disabled: isLoading,
                  onPressed: () {
                    submit();
                  },
                ),
              ],
            ),
            if (hasError && validateUserError != null) Error(validateUserError),
          ],
        ),
      ],
    );
  }

  void submit() {
    context.read<AuthModel>().validateUser(code).then((_) {
      Navigator.of(context).pushReplacementNamed(CommonNavigator.homeRoute);
    }).catchError((error) {
      logger.warning(error);
    });
  }
}
