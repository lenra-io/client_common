import 'dart:async';

import 'package:catcher/model/platform_type.dart';
import 'package:catcher/model/report.dart';
import 'package:catcher/model/report_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LenraReportMode extends ReportMode {
  final streamController = StreamController<dynamic>();

  @override
  void requestAction(Report report, BuildContext? context) {
    if (report.error is FlutterError) {
      // Show error to console when in debug mode
      if (kDebugMode) {
        print(report.error);
        print(report.stackTrace);
      }
      // Report error to Sentry and do not show dialog
      super.onActionConfirmed(report);
    } else {
      super.onActionConfirmed(report);
      streamController.add(report.error);
    }
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
}
