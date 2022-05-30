import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/lenra_application/api_error_snack_bar.dart';
import 'package:client_common/lenra_application/app_error_page.dart';
import 'package:client_common/lenra_application/lenra_error_page.dart';
import 'package:client_common/models/channel_model.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';
import 'package:provider/provider.dart';

class LenraUiController extends StatefulWidget {
  @override
  State<LenraUiController> createState() {
    return _LenraUiControllerState();
  }
}

class _LenraUiControllerState extends State<LenraUiController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChannelModel channelModel = context.watch<ChannelModel>();
    Widget res;
    if (channelModel.hasError) {
      res = LenraErrorPage(apiErrors: channelModel.errors!);
    } else if (!channelModel.isInitialized) {
      res = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      res = LenraWidget<ApiErrors>(
        buildErrorPage: (BuildContext context, ApiErrors errors) => AppErrorPage(apiErrors: errors),
        showSnackBar: (BuildContext context, ApiErrors errors) => {
          ScaffoldMessenger.of(context).showSnackBar(ApiErrorSnackBar(
            errors: errors,
            onPressAction: () => ScaffoldMessenger.of(context).clearSnackBars(),
            actionLabel: "Ok",
          )),
        },
      );
    }
    return Scaffold(body: res);
  }
}
