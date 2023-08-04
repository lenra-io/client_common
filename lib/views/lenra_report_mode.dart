import 'package:catcher/model/platform_type.dart';
import 'package:catcher/model/report.dart';
import 'package:catcher/model/report_mode.dart';
import 'package:catcher/utils/catcher_utils.dart';
import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LenraReportMode extends ReportMode {
  @override
  void requestAction(Report report, BuildContext? context) {
    _showDialog(report, context);
  }

  Future _showDialog(Report report, BuildContext? context) async {
    if (context != null) {
      if (CatcherUtils.isCupertinoAppAncestor(context)) {
        return showCupertinoDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => _buildCupertinoDialog(report, context),
        );
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => _buildMaterialDialog(report, context),
        );
      }
    }
  }

  Widget _buildCupertinoDialog(Report report, BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        super.onActionRejected(report);
        return true;
      },
      child: CupertinoAlertDialog(
        title: Text(getDialogTitle(report)),
        content: Text(getDialogContent(report)),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => _onAcceptReportClicked(context, report),
            child: Text(localizationOptions.dialogReportModeAccept),
          ),
          CupertinoDialogAction(
            onPressed: () => _onCancelReportClicked(context, report),
            child: Text(localizationOptions.dialogReportModeCancel),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialDialog(Report report, BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        super.onActionRejected(report);
        return true;
      },
      child: AlertDialog(
        title: Text(getDialogTitle(report)),
        content: Text(getDialogContent(report)),
        actions: <Widget>[
          TextButton(
            onPressed: () => _onAcceptReportClicked(context, report),
            child: const Text('Send Report'),
          ),
          TextButton(
            onPressed: () => _onCancelReportClicked(context, report),
            child: const Text('Ignore'),
          ),
        ],
      ),
    );
  }

  void _onAcceptReportClicked(BuildContext context, Report report) {
    super.onActionConfirmed(report);
    Navigator.pop(context);
  }

  void _onCancelReportClicked(BuildContext context, Report report) {
    super.onActionRejected(report);
    Navigator.pop(context);
  }

  @override
  bool isContextRequired() {
    return true;
  }

  @override
  List<PlatformType> getSupportedPlatforms() => [
        PlatformType.android,
        PlatformType.iOS,
        PlatformType.web,
        PlatformType.linux,
        PlatformType.macOS,
        PlatformType.windows,
      ];

  String getDialogTitle(Report report) {
    return "An error occured";
  }

  String getDialogContent(Report report) {
    if (report.error.runtimeType == ApiError) {
      return (report.error as ApiError).message;
    }

    return "Content";
  }
}
