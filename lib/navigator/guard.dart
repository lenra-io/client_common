import 'dart:async';

import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/models/user_application_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This class defines guards that are used to stop the user from accessing certain pages.
class Guard {
  Future<bool> Function(BuildContext) isValid;
  Function(BuildContext) onInvalid;

  Guard({required this.isValid, required this.onInvalid});

  static const List<UserRole> _devOrMore = [UserRole.admin, UserRole.dev];

  static final Guard checkIsDev = Guard(isValid: _isDev, onInvalid: _becomeDev);
  static final Guard checkNotHaveApp = Guard(isValid: _haveApp(false), onInvalid: _toHome);

  static Future<bool> _isDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(_devOrMore);
  }

  static Future<String?> guards(BuildContext context, List<Guard> guards) async {
    for (Guard checker in guards) {
      try {
        if (!await checker.isValid(context)) {
          return checker.onInvalid(context);
        }
      } catch (e) {
        return checker.onInvalid(context);
      }
    }
    return null;
  }

  static Future<bool> Function(BuildContext) _haveApp(bool mustHaveApp) {
    return (BuildContext context) async {
      try {
        List<AppResponse> userApps = await context.read<UserApplicationModel>().fetchUserApplications();
        return userApps.isNotEmpty == mustHaveApp;
      } catch (e) {
        return false;
      }
    };
  }

  static String _becomeDev(context) {
    return CommonNavigator.validationDevRoute;
  }

  static String _toHome(context) {
    return CommonNavigator.homeRoute;
  }
}
