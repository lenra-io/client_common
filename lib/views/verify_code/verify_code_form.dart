import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/error_list.dart';
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
    ApiErrors? validateUserErrors = context
        .select<AuthModel, ApiErrors?>((m) => m.validateUserStatus.errors);
    bool hasError =
        context.select<AuthModel, bool>((m) => m.validateUserStatus.hasError());
    bool isLoading = context
        .select<AuthModel, bool>((m) => m.validateUserStatus.isFetching());

    return LenraFlex(
      direction: Axis.vertical,
      spacing: 4,
      children: [
        LenraFlex(
          direction: Axis.vertical,
          spacing: 2,
          children: [
            LenraFlex(
              spacing: 2,
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
            if (hasError) ErrorList(validateUserErrors),
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
