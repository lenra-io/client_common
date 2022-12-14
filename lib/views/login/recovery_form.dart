import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/error.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class RecoveryForm extends StatefulWidget {
  @override
  State<RecoveryForm> createState() {
    return _RecoveryFormState();
  }
}

class _RecoveryFormState extends State<RecoveryForm> {
  final logger = Logger("RecoveryForm");

  final _formKey = GlobalKey<FormState>();
  String email = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;
    ApiError? askCodeLostPasswordError = context.select<AuthModel, ApiError?>((m) => m.askCodeLostPasswordStatus.error);
    return Form(
      key: _formKey,
      child: LenraFlex(
        direction: Axis.vertical,
        spacing: 24,
        children: <Widget>[
          Text(
            "Confirm your email and we'll take care of it.",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.disabledBodyText,
          ),
          LenraTextFormField(
            hintText: "email@email.com",
            onChanged: (String value) {
              email = value;
            },
            onSubmitted: (_) {
              submit();
            },
            type: LenraTextFormFieldType.email,
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              text: "Reset my password",
              onPressed: () {
                submit();
              },
            ),
          ),
          if (askCodeLostPasswordError != null) Error(askCodeLostPasswordError),
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      authModel.askCodeLostPassword(email).then((_) {
        if (!authModel.askCodeLostPasswordStatus.hasError() && authModel.askCodeLostPasswordStatus.isDone()) {
          CommonNavigator.go(context, CommonNavigator.changeLostPassword, extra: email);
        }
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
