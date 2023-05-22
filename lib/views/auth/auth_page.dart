import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/loading_button.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class AppAuthPage extends StatefulWidget {
  @override
  State<AppAuthPage> createState() => _AppAuthPageState();
}

class _AppAuthPageState extends State<AppAuthPage> {
  final logger = Logger('AuthPage');
  final _formKey = GlobalKey<FormState>();

  bool isRegisterPage = true;
  String email = "";
  String password = "";

  bool keep = false;
  bool _hidePassword = true;
  var themeData = LenraThemeData();

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      header: Container(),
      child: LenraFlex(
        spacing: 32,
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
          ),
          LenraText(
            text: "App Name",
            style: themeData.lenraTextThemeData.headline1,
          ),
          LenraFlex(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LenraText(text: "by"),
              Image.asset(
                "assets/images/logo-horizontal-black.png",
                scale: 1.5,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline),
              )
            ],
          ),
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
                    setState(() {
                      isRegisterPage = true;
                    });
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
                    setState(() {
                      isRegisterPage = false;
                    });
                  },
                  child: LenraText(
                    text: "Log in",
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
      ),
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
            hintText: 'email@email.com',
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
            onPressed: () {},
            loading: true,
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
            hintText: 'email@email.com',
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
                style: themeData.lenraTextThemeData.disabledBodyText,
              ),
            ],
          ),
          LoadingButton(
            text: "Log in",
            onPressed: () {},
            loading: true,
          ),
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      if (isRegisterPage) {
        authModel.register(email, password).then((_) {
          GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
        }).catchError((error) {
          logger.warning(error);
        });
      } else {
        authModel.login(email, password, keep).then((_) {
          GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
        }).catchError((error) {
          logger.warning(error);
        });
      }
    }
  }
}
