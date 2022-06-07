import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/views/error.dart';
import 'package:flutter/material.dart';

class ErrorList extends StatelessWidget {
  final ApiErrors? errors;
  ErrorList(this.errors);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: errors?.map((error) => Error(error)).toList() ?? [],
    );
  }
}
