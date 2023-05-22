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

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    var themeData = LenraThemeData();
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
                  onPressed: () {},
                  child: LenraText(
                    text: "Inscription",
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
                  onPressed: () {},
                  child: LenraText(
                    text: "Connexion",
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
          Form(
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
          ),
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      authModel.register(email, password).then((_) {
        GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
