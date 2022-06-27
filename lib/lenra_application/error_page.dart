import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/widgets.dart';
import 'package:lenra_components/lenra_components.dart';

class ErrorPage extends StatelessWidget {
  final ApiError apiError;
  final String title;
  final String message;
  final String contactMessage;

  ErrorPage({
    required this.apiError,
    required this.title,
    required this.message,
    required this.contactMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SimplePage(
        title: title,
        message: message,
        child: LenraFlex(
          direction: Axis.vertical,
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            errorToWidget(),
            Image.asset(
              'assets/images/colored-line.png',
            ),
            Text(
              contactMessage,
            ),
          ],
        ));
  }

  Widget errorToWidget() {
    return Text("Error ${apiError.code.toString()} : ${apiError.message}");
  }
}
