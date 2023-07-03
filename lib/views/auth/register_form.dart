import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/error.dart';
import 'package:client_common/views/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final logger = Logger('RegisterForm');
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool keep = false;
  bool _hidePassword = true;

  bool isLogging = false;

  @override
  Widget build(BuildContext context) {
    isLogging = context.select<AuthModel, bool>(
      (m) => m.registerStatus.isFetching(),
    );

    ApiError? registerError = context.select<AuthModel, ApiError?>((m) => m.registerStatus.error);

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
          if (registerError != null) Error(registerError),
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

  void submit() {
    if (_formKey.currentState!.validate()) {
      AuthModel authModel = context.read<AuthModel>();
      final future = authModel.register(email, password);
      future.then((_) {
        GoRouter.of(context).go(context.read<AuthModel>().redirectToRoute ?? '/');
      }).catchError((error) {
        logger.warning(error);
      });
    }
  }
}
