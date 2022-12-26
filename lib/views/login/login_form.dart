import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/error.dart';
import 'package:client_common/views/loading_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final logger = Logger("LoginForm");

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool keep = false;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;
    ApiError? loginError = context.select<AuthModel, ApiError?>((m) => m.loginStatus.error);

    return Form(
      key: _formKey,
      child: LenraFlex(
        direction: Axis.vertical,
        spacing: 16,
        children: <Widget>[
          login(context),
          Image.asset(
            'assets/images/colored-line.png',
          ),
          Text(
            "You don't have a Lenra account yet?",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.disabledBodyText,
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              type: LenraComponentType.secondary,
              text: "Create my account",
              onPressed: () {
                CommonNavigator.go(context, CommonNavigator.register);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                text: "I forgot my password",
                style: finalLenraTextThemeData.blueBodyText,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    CommonNavigator.go(context, CommonNavigator.lostPassword);
                  },
              ),
            ),
          ),
          if (loginError != null) Error(loginError),
        ],
      ),
    );
  }

  Widget login(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

    bool isLogging = context.select<AuthModel, bool>((m) => m.loginStatus.isFetching());
    return LenraFlex(
      direction: Axis.vertical,
      spacing: 16,
      children: [
        //------Email------
        LenraTextFormField(
          label: 'Your email',
          hintText: 'Email',
          onChanged: (String value) {
            email = value;
          },
          onSubmitted: (_) {
            submit();
          },
          type: LenraTextFormFieldType.email,
          size: LenraComponentSize.large,
          autofillHints: [AutofillHints.email],
        ),
        //------Password------
        LenraTextFormField(
          label: 'Your password',
          obscure: _hidePassword,
          hintText: 'Password',
          onChanged: (String value) {
            password = value;
          },
          onSubmitted: (_) {
            submit();
          },
          type: LenraTextFormFieldType.password,
          size: LenraComponentSize.large,
          autofillHints: [AutofillHints.password],
          onSuffixPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
        ),
        LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraCheckbox(
              value: keep,
              onPressed: (value) {
                setState(() {
                  keep = value!;
                });
              },
            ),
            LenraText(
              text: "Keep me logged in",
              style: finalLenraTextThemeData.disabledBodyText,
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: LoadingButton(
            text: "Log in",
            onPressed: () {
              submit();
            },
            loading: isLogging,
          ),
        ),
      ],
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      authModel.login(email, password, keep).then((_) {
        CommonNavigator.goPath(context, authModel.getRedirectionRouteAfterAuthentication());
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
