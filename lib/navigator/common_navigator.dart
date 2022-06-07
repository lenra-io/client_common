import 'package:client_common/navigator/guard.dart';
import 'package:client_common/navigator/page_guard.dart';
import 'package:client_common/views/cgu/cgu_page.dart';
import 'package:client_common/views/cgu/cgu_page_fr.dart';
import 'package:client_common/views/login/login_page.dart';
import 'package:client_common/views/profile/change_lost_password_page.dart';
import 'package:client_common/views/profile/change_password_confirmation_page.dart';
import 'package:client_common/views/profile/profile_page.dart';
import 'package:client_common/views/profile/recovery_page.dart';
import 'package:client_common/views/register/register_page.dart';
import 'package:client_common/views/verify_code/verifiying_code_page.dart';
import 'package:flutter/widgets.dart';

typedef CustomPageBuilder = Widget Function(Map<String, String>);

class CommonNavigator {
  static const String homeRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String lostPasswordRoute = "/lost";
  static const String changeLostPasswordRoute = "/change-lost";
  static const String changePasswordConfirmationRoute = "/change-confirmation";
  static const String validationDevRoute = "/validation-dev";
  static const String userValidationRoute = "/validation-user";
  static const String cguRoute = "/cgu";
  static const String cguRouteFR = "/cgu/fr";
  static const String profileRoute = "/profile";

  static String? currentRoute;

  static final Map<String, CustomPageBuilder> authRoutes = {
    changeLostPasswordRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: ChangeLostPasswordPage(),
        ),
    lostPasswordRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: RecoveryPage(),
        ),
    changePasswordConfirmationRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: ChangePasswordConfirmationPage(),
        ),
    profileRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: ProfilePage(),
        ),
    loginRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: LoginPage(),
        ),
    registerRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: RegisterPage(),
        ),
    cguRoute: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: CguPage(),
        ),
    cguRouteFR: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: CguPageFr(),
        ),
    userValidationRoute: (Map<String, String> params) => PageGuard(
          guards: [
            Guard.checkAuthenticated,
            Guard.checkCguAccepted,
            Guard.checkIsNotUser,
          ],
          child: VerifyingCodePage(),
        ),
  };
}
