import 'dart:async';

import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/models/cgu_model.dart';
import 'package:client_common/models/user_application_model.dart';
import 'package:client_common/navigator/common_navigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// This class defines guards that are used to stop the user from accessing certain pages.
class Guard {
  Future<bool> Function(BuildContext) isValid;
  Function(BuildContext) onInvalid;

  Guard({required this.isValid, required this.onInvalid});

  static const List<UserRole> _devOrMore = [UserRole.admin, UserRole.dev];
  static const List<UserRole> _userOrMore = [UserRole.user, UserRole.admin, UserRole.dev];

  static final Guard checkIsDev = Guard(isValid: _isDev, onInvalid: _becomeDev);
  static final Guard checkIsNotDev = Guard(isValid: _isNotDev, onInvalid: _toHome);
  static final Guard checkUnauthenticated = Guard(isValid: _isAuthenticated(false), onInvalid: _toHome);
  static final Guard checkAuthenticated = Guard(isValid: _isAuthenticated(true), onInvalid: _toLogin);
  static final Guard checkNotHaveApp = Guard(isValid: _haveApp(false), onInvalid: _toHome);
  static final Guard checkCguAccepted = Guard(isValid: _isCguAccepted(), onInvalid: _toCgu);
  static final Guard checkIsUser = Guard(isValid: _isUser, onInvalid: _becomeUser);
  static final Guard checkIsNotUser = Guard(isValid: _isNotUser, onInvalid: _toHome);

  static Future<bool> Function(BuildContext) _isAuthenticated(bool mustBeAuthenticated) {
    return (BuildContext context) async {
      AuthModel authModel = context.read<AuthModel>();
      if (!authModel.isAuthenticated() && authModel.refreshStatus.isNone()) {
        try {
          await authModel.refresh();
        } catch (e) {
          return authModel.isAuthenticated() == mustBeAuthenticated;
        }
        /*if (authModel.refreshStatus.isNone())
          // Try to auth user with refresh token
          await authModel.refresh().catchError((e) => null);
        else if (authModel.refreshStatus.isFetching())
          // Wait current refresh response
          await authModel.refreshStatus.wait().catchError((e) => null);*/
      }
      // then check everything
      return authModel.isAuthenticated() == mustBeAuthenticated;
    };
  }

  static Future<bool> _isUser(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(_userOrMore);
  }

  static Future<bool> _isNotUser(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(UserRole.values.where((ur) => !_userOrMore.contains(ur)).toList());
  }

  static Future<bool> _isDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(_devOrMore);
  }

  static Future<bool> _isNotDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(UserRole.values.where((ur) => !_devOrMore.contains(ur)).toList());
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

  static Future<bool> Function(BuildContext) _isCguAccepted() {
    return (BuildContext context) async {
      CguModel cguModel = context.read<CguModel>();
      bool res = await cguModel.userAcceptedLatestCgu().then((value) => value.accepted);
      return res;
    };
  }

  static void _toLogin(BuildContext context) {
    context.read<AuthModel>().redirectToRoute = CommonNavigator.currentLocation(context);

    CommonNavigator.go(context, CommonNavigator.login);
  }

  static void _becomeDev(context) {
    CommonNavigator.goPath(context, CommonNavigator.validationDevRoute);
  }

  static void _toHome(context) {
    GoRouter.of(context).go(CommonNavigator.homeRoute);
  }

  static void _toCgu(context) {
    CommonNavigator.go(context, CommonNavigator.cgu);
  }

  static void _becomeUser(context) {
    CommonNavigator.go(context, CommonNavigator.userValidation);
  }
}
