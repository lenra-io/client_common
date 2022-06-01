import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/error_list.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_text_form_field.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/utils/form_validators.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class ChangeLostPasswordForm extends StatefulWidget {
  final String? email;

  ChangeLostPasswordForm({this.email});

  @override
  State<ChangeLostPasswordForm> createState() {
    return _ChangeLostPasswordState();
  }
}

class _ChangeLostPasswordState extends State<ChangeLostPasswordForm> {
  final logger = Logger("ChangeLostPasswordForm");

  final _formKey = GlobalKey<FormState>();
  String? email;

  String newPassword = "";
  String newPasswordConfirmation = "";

  String code = "";
  final bool _passwordVisible;
  final bool _passwordVisibleConfirm;

  _ChangeLostPasswordState()
      : _passwordVisible = true,
        _passwordVisibleConfirm = true;

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData =
        LenraTheme.of(context).lenraTextThemeData;

    ApiErrors? sendCodeLostPasswordErrors =
        context.select<AuthModel, ApiErrors?>(
            (m) => m.sendCodeLostPasswordStatus.errors);

    return Form(
      key: _formKey,
      child: LenraFlex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 3,
        children: <Widget>[
          ...widget.email == null
              ? [
                  LenraTextFormField(
                    label: "Your email",
                    onChanged: (String value) {
                      email = value;
                    },
                    type: LenraTextFormFieldType.email,
                  )
                ]
              : [],
          LenraTextFormField(
            label: "Enter the received code",
            description:
                "If you didn't receive the code, check your email again then contact us.",
            onChanged: (String value) {
              code = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 8),
            ]),
          ),
          Text(
            "New password",
            textAlign: TextAlign.left,
            style: finalLenraTextThemeData.headline3,
          ),
          LenraTextFormField(
            label: "Set your password",
            description:
                "8 characters, 1 uppercase, 1 lowercase and 1 special character.",
            obscure: _passwordVisible,
            onChanged: (String value) {
              newPassword = value;
            },
            onSubmitted: (_) {
              submit();
            },
            type: LenraTextFormFieldType.password,
          ),
          LenraTextFormField(
            label: "Confirm your password",
            obscure: _passwordVisibleConfirm,
            onChanged: (String value) {
              newPasswordConfirmation = value;
            },
            onSubmitted: (_) {
              submit();
            },
            type: LenraTextFormFieldType.password,
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              text: "Change my password",
              onPressed: () {
                submit();
              },
            ),
          ),
          ErrorList(sendCodeLostPasswordErrors),
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      authModel
          .sendCodeLostPassword(
        code,
        widget.email ?? email!,
        newPassword,
        newPasswordConfirmation,
      )
          .then((_) {
        if (!authModel.sendCodeLostPasswordStatus.hasError() &&
            authModel.sendCodeLostPasswordStatus.isDone()) {
          Navigator.of(context).pushReplacementNamed(
              CommonNavigator.changePasswordConfirmationRoute);
        }
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
