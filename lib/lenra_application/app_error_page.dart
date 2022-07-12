import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/lenra_application/error_page.dart';
import 'package:flutter/material.dart';

class AppErrorPage extends StatelessWidget {
  final ApiError apiError;

  AppErrorPage({required this.apiError});
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      apiError: apiError,
      title: "Application encountered an unexpected error",
      message: "Please try again later",
      contactMessage: "If the problem persists, please contact the app Developper.",
    );
  }
}
