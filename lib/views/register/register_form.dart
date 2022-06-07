import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/error_list.dart';
import 'package:client_common/views/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final logger = Logger('RegisterForm');

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;
    ApiErrors? registerErrors = context.select<AuthModel, ApiErrors?>((m) => m.registerStatus.errors);
    return Form(
      key: _formKey,
      child: LenraFlex(
        direction: Axis.vertical,
        spacing: 5,
        children: [
          fields(context),
          //------Button------
          validationButton(context),
          Text(
            "Please notice that Lenra is in its beta version, bugs may occur and features might be missing.",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.disabledBodyText,
          ),

          ErrorList(registerErrors)
        ],
      ),
    );
  }

  Widget validationButton(BuildContext context) {
    bool isRegistering = context.select<AuthModel, bool>((m) => m.registerStatus.isFetching());
    return SizedBox(
      width: double.infinity,
      child: LoadingButton(
        text: "Create my account",
        onPressed: () {
          submit();
        },
        loading: isRegistering,
      ),
    );
  }

  Widget fields(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      spacing: 2,
      children: [
        //------Email------
        LenraTextFormField(
          label: 'Set a login ID',
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
          label: 'Set a password',
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
      ],
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      authModel.register(email, password).then((_) {
        Navigator.of(context).pushReplacementNamed(authModel.getRedirectionRouteAfterAuthentication());
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
