import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final ApiError error;

  Error(this.error);
  @override
  Widget build(BuildContext context) {
    return Text(
      error.message,
      style: TextStyle(color: Theme.of(context).errorColor),
    );
  }
}
