import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/lenra_application/error_page.dart';
import 'package:flutter/material.dart';

class AppErrorPage extends StatelessWidget {
  final ApiErrors apiErrors;

  AppErrorPage({required this.apiErrors});
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      apiErrors: apiErrors,
      title: "Application encountered an unexpected error",
      message: "Please try again later",
      contactMessage: "If the problem persists, please contact the app Developper.",
    );
  }
}
