import 'dart:async';

import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/models/user_application_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:client_common/views/auth/oauth_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// This class defines guards that are used to stop the user from accessing certain pages.
class Guard {
  Future<bool> Function(BuildContext) isValid;
  Function(BuildContext) onInvalid;

  Guard({required this.isValid, required this.onInvalid});

  static const List<UserRole> _devOrMore = [UserRole.admin, UserRole.dev];

  static final Guard checkIsDev = Guard(isValid: _isDev, onInvalid: _becomeDev);
  static final Guard checkIsNotDev = Guard(isValid: _isNotDev, onInvalid: _toHome);
  static final Guard checkNotHaveApp = Guard(isValid: _haveApp(false), onInvalid: _toHome);
  static final Guard checkIsAuthenticated = Guard(isValid: _isAuthenticated, onInvalid: _toOauth);

  static Future<bool> _isAuthenticated(BuildContext context) async {
    return OAuthPageState.isAuthenticated(context);
  }

  static Future<bool> _isDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(_devOrMore);
  }

  static Future<bool> _isNotDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    print("CHECKIGN IS NOT DEV");
    print(authModel.user?.role);
    return authModel.isOneOfRole(UserRole.values.where((ur) => !_devOrMore.contains(ur)).toList());
  }

  static Future<String?> guards(BuildContext context, List<Guard> guards) async {
    // TODO: Find a way to get the GoRouter here or find another way of setting the current location to the AuthModel
    // TODO: There is no way to get the current route from the GoRouter here because the context is empty if the redirect
    // TODO: is called at the root of the application. This is because the last route in the context was poped.
    print("CURRENT ROUTE");
    print(GoRouter.of(context).location);
    context.read<AuthModel>().redirectToRoute = GoRouter.of(context).location;
    print(context.read<AuthModel>().redirectToRoute);
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
      List<AppResponse> userApps = await context.read<UserApplicationModel>().fetchUserApplications();
      return userApps.isNotEmpty == mustHaveApp;
    };
  }

  static String _becomeDev(context) {
    return CommonNavigator.validationDevRoute;
  }

  static String _toHome(context) {
    return CommonNavigator.homeRoute;
  }

  static String _toOauth(context) {
    return CommonNavigator.oauth.path;
  }
}
