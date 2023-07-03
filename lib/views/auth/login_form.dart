import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/error.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final logger = Logger('LoginForm');
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool keep = false;
  bool _hidePassword = true;

  bool isLogging = false;

  @override
  Widget build(BuildContext context) {
    isLogging = context.select<AuthModel, bool>(
      (m) => m.loginStatus.isFetching(),
    );

    ApiError? loginError = context.select<AuthModel, ApiError?>((m) => m.loginStatus.error);

    var themeData = LenraThemeData();
    return Form(
      key: _formKey,
      child: LenraFlex(
        spacing: 24,
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            fillParent: true,
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
                style: themeData.lenraTextThemeData.disabledBodyText,
              ),
            ],
          ),
          if (loginError != null) Error(loginError),
          LenraFlex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: !isLogging
                    ? () {
                        submit();
                      }
                    : null,
                child: LenraText(text: "Login", style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return themeData.lenraColorThemeData.primaryBackgroundDisabledColor;
                    } else if (states.contains(MaterialState.hovered)) {
                      return themeData.lenraColorThemeData.primaryBackgroundHoverColor;
                    }
                    return themeData.lenraColorThemeData.primaryBackgroundColor;
                  }),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(Size(136, 36)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: RichText(
                  text: TextSpan(
                    text: "I forgot my password",
                    style: themeData.lenraTextThemeData.blueBodyText,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        CommonNavigator.go(context, CommonNavigator.lostPassword);
                      },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      final future = authModel.login(email, password, keep);
      future.then((_) {
        GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
