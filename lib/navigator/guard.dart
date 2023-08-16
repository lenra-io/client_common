import 'dart:async';

import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/models/user_application_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/oauth/oauth_model.dart';
import 'package:client_common/views/auth/oauth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef IsValid = Future<bool> Function(BuildContext);

/// This class defines guards that are used to stop the user from accessing certain pages.
class Guard {
  IsValid isValid;
  Function(BuildContext) onInvalid;

  Guard({required this.isValid, required this.onInvalid});

  static const List<UserRole> _devOrMore = [UserRole.admin, UserRole.dev];

  static final Guard checkIsDev = Guard(isValid: isDev, onInvalid: _becomeDev);
  static final Guard checkIsNotDev = Guard(isValid: isNotDev, onInvalid: toHome);
  static final Guard checkNotHaveApp = Guard(isValid: haveApp(false), onInvalid: toHome);
  static final Guard checkIsAuthenticated = Guard(isValid: isAuthenticated, onInvalid: toOauth);

  static Future<bool> isAuthenticated(BuildContext context) async {
    return OAuthPageState.isAuthenticated(context);
  }

  static Future<bool> isDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(_devOrMore);
  }

  static Future<bool> isNotDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(UserRole.values.where((ur) => !_devOrMore.contains(ur)).toList());
  }

  static IsValid haveApp(bool mustHaveApp) {
    return (BuildContext context) async {
      List<AppResponse> userApps = await context.read<UserApplicationModel>().fetchUserApplications();
      return userApps.isNotEmpty == mustHaveApp;
    };
  }

  static String _becomeDev(context) {
    return CommonNavigator.validationDevRoute;
  }

  static String toHome(context) {
    return CommonNavigator.homeRoute;
  }

  static String toOauth(context) {
    return CommonNavigator.oauth.path;
  }

  static Future<String?> guards(BuildContext context, List<Guard> guards, {Map<String, dynamic>? metadata}) async {
    if (metadata?.containsKey('initialRoute') ?? false) {
      context.read<OAuthModel>().beforeRedirectPath = metadata!["initialRoute"];
    }

    for (Guard checker in guards) {
      if (!await checker.isValid(context)) {
        return checker.onInvalid(context);
      }
    }
    return null;
  }
}
