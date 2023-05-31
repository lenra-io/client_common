import 'package:client_common/models/auth_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/loading_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class AuthPageForm extends StatefulWidget {
  final bool? isRegisterPage;
  AuthPageForm(this.isRegisterPage, {Key? key}) : super(key: key);

  @override
  State<AuthPageForm> createState() => _AuthPageFormState();
}

class _AuthPageFormState extends State<AuthPageForm> {
  final logger = Logger('AuthPageForm');
  final _formKey = GlobalKey<FormState>();

  bool isRegisterPage = true;
  String email = "";
  String password = "";

  bool keep = false;
  bool _hidePassword = true;
  var themeData = LenraThemeData();
  bool isLogging = false;

  String? redirectTo;
  String? appServiceName;

  @override
  void initState() {
    super.initState();
    isRegisterPage = widget.isRegisterPage ?? true;
  }

  @override
  Widget build(BuildContext context) {
    isLogging = context.select<AuthModel, bool>(
      (m) => isRegisterPage ? m.registerStatus.isFetching() : m.loginStatus.isFetching(),
    );

    redirectTo = context.read<AuthModel>().redirectToRoute;
    print("redirectTo $redirectTo");
    RegExp regExp = RegExp(r"app\/([a-fA-F0-9-]{36})");
    final match = regExp.firstMatch(redirectTo ?? "/");
    appServiceName = match?.group(1);
    print("appServiceName $appServiceName");

    return LenraFlex(
      spacing: 32,
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      fillParent: true,
      children: [
        Container(
          decoration: BoxDecoration(
            color: LenraColorThemeData.greySuperLight,
            borderRadius: BorderRadius.circular(32),
          ),
          child: LenraFlex(
            spacing: 16,
            children: [
              TextButton(
                onPressed: () {
                  if (!isRegisterPage) {
                    setState(() {
                      isRegisterPage = true;
                    });
                  }
                },
                child: LenraText(
                  text: "Register",
                  style: isRegisterPage
                      ? TextStyle(color: LenraColorThemeData.lenraWhite)
                      : TextStyle(color: LenraColorThemeData.lenraBlue),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (isRegisterPage) {
                      return LenraColorThemeData.lenraBlue;
                    }
                    return LenraColorThemeData.greySuperLight;
                  }),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(Size(136, 36)),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isRegisterPage) {
                    setState(() {
                      isRegisterPage = false;
                    });
                  }
                },
                child: LenraText(
                  text: "Login",
                  style: !isRegisterPage
                      ? TextStyle(color: LenraColorThemeData.lenraWhite)
                      : TextStyle(color: LenraColorThemeData.lenraBlue),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (!isRegisterPage) {
                      return LenraColorThemeData.lenraBlue;
                    }
                    return LenraColorThemeData.greySuperLight;
                  }),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(Size(136, 36)),
                ),
              ),
            ],
          ),
        ),
        isRegisterPage ? registerForm() : loginForm(),
      ],
    );
  }

  Widget registerForm() {
    return Form(
      key: _formKey,
      child: LenraFlex(
        spacing: 24,
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            size: LenraComponentSize.large,
            type: LenraTextFormFieldType.email,
            autofillHints: [AutofillHints.email],
          ),
          //------Password------
          LenraTextFormField(
            label: 'Your password',
            description: "8 characters, 1 uppercase, 1 lowercase and 1 special character.",
            obscure: _hidePassword,
            hintText: 'Password',
            onSubmitted: (_) {
              submit();
            },
            onChanged: (String value) {
              password = value;
            },
            size: LenraComponentSize.large,
            type: LenraTextFormFieldType.password,
            autofillHints: [AutofillHints.newPassword],
            onSuffixPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
          ),
          LoadingButton(
            text: "Create my account",
            onPressed: () {
              submit();
            },
            loading: isLogging,
          ),
        ],
      ),
    );
  }

  Widget loginForm() {
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
          LenraFlex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LenraButton(
                onPressed: !isLogging
                    ? () {
                        submit();
                      }
                    : null,
                disabled: isLogging ? true : false,
                text: "Login",
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
      final future = isRegisterPage ? authModel.register(email, password) : authModel.login(email, password, keep);
      future.then((_) {
        GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
