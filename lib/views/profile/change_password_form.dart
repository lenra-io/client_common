import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/error_list.dart';
import 'package:client_common/views/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/utils/form_validators.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  State<ChangePasswordForm> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePasswordForm> {
  final logger = Logger('ChangePasswordForm');

  final _formKey = GlobalKey<FormState>();
  String oldPassword = "";
  String newPassword = "";
  String newPasswordConfirmation = "";

  bool _passwordVisible = true;
  bool _passwordVisibleConfirm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isChangingPassword = context
        .select<AuthModel, bool>((m) => m.changePasswordStatus.isFetching());
    ApiErrors? changePasswordErrors = context
        .select<AuthModel, ApiErrors?>((m) => m.changePasswordStatus.errors);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Set your password',
              labelText: 'Password :',
            ),
            obscureText: true,
            onChanged: (String value) {
              setState(() {
                oldPassword = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Your new password',
              labelText: 'New password :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            obscureText: _passwordVisible,
            onChanged: (String value) {
              setState(() {
                newPassword = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Confirm your new password',
              labelText: 'New password :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisibleConfirm
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisibleConfirm = !_passwordVisibleConfirm;
                  });
                },
              ),
            ),
            obscureText: _passwordVisibleConfirm,
            onChanged: (String value) {
              setState(() {
                newPasswordConfirmation = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: LoadingButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<AuthModel>()
                      .changePassword(
                        oldPassword,
                        newPassword,
                        newPasswordConfirmation,
                      )
                      .catchError((error) {
                    logger.warning(error);
                  });
                }
              },
              text: 'Update my password',
              loading: isChangingPassword,
            ),
          ),
          ErrorList(changePasswordErrors),
        ],
      ),
    );
  }
}
