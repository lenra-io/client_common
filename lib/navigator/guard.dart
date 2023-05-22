import 'dart:async';

import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/user.dart';
import 'package:client_common/models/auth_model.dart';
import 'package:client_common/models/cgu_model.dart';
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
  static const List<UserRole> _userOrMore = [UserRole.user, UserRole.admin, UserRole.dev];

  static final Guard checkIsDev = Guard(isValid: _isDev, onInvalid: _becomeDev);
  static final Guard checkIsNotDev = Guard(isValid: _isNotDev, onInvalid: _toHome);
  static final Guard checkUnauthenticated = Guard(isValid: _isAuthenticated(false), onInvalid: _toHome);
  static final Guard checkAuthenticated = Guard(isValid: _isAuthenticated(true), onInvalid: _toRegister);
  static final Guard checkAuthenticatedForApp = Guard(isValid: _isAuthenticated(true), onInvalid: _toAuth);
  static final Guard checkNotHaveApp = Guard(isValid: _haveApp(false), onInvalid: _toHome);
  static final Guard checkCguAccepted = Guard(isValid: _isCguAccepted(), onInvalid: _toCgu);
  static final Guard checkIsUser = Guard(isValid: _isUser, onInvalid: _becomeUser);
  static final Guard checkIsNotUser = Guard(isValid: _isNotUser, onInvalid: _toHome);

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

  static Future<bool> Function(BuildContext) _isAuthenticated(bool mustBeAuthenticated) {
    return (BuildContext context) async {
      AuthModel authModel = context.read<AuthModel>();
      if (!authModel.isAuthenticated() && authModel.refreshStatus.isNone()) {
        try {
          await authModel.refresh();
        } catch (e) {
          return authModel.isAuthenticated() == mustBeAuthenticated;
        }
      }

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

  static String _toRegister(BuildContext context) {
    try {
      context.read<AuthModel>().redirectToRoute = CommonNavigator.currentLocation(context);
    } catch (_) {
      context.read<AuthModel>().redirectToRoute = "/";
    }

    return CommonNavigator.register.path;
  }

  static String _toAuth(BuildContext context) {
    try {
      context.read<AuthModel>().redirectToRoute = CommonNavigator.currentLocation(context);
    } catch (_) {
      context.read<AuthModel>().redirectToRoute = "/";
    }

    return CommonNavigator.authRoute.path;
  }

  static String _becomeDev(context) {
    return CommonNavigator.validationDevRoute;
  }

  static String _toHome(context) {
    return CommonNavigator.homeRoute;
  }

  static String _toCgu(context) {
    return CommonNavigator.cgu.path;
  }

  static String _becomeUser(context) {
    return CommonNavigator.userValidation.path;
  }
}
