import 'package:client_common/navigator/guard.dart';
import 'package:client_common/navigator/page_guard.dart';
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

  static final Map<String, CustomPageBuilder> authRoutes = {
    CHANGE_LOST_PASSWORD_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: ChangeLostPasswordPage(),
        ),
    LOST_PASSWORD_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: RecoveryPage(),
        ),
    CHANGE_PASSWORD_CONFIRMATION_ROUTE: (Map<String, String> params) =>
        PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: ChangePasswordConfirmationPage(),
        ),
    PROFILE_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: ProfilePage(),
        ),
    LOGIN_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: LoginPage(),
        ),
    REGISTER_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: RegisterPage(),
        ),
    CGU_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: CguPage(),
        ),
    CGU_ROUTE_FR: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: CguPageFr(),
        ),
    USER_VALIDATION_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [
            Guard.checkAuthenticated,
            Guard.checkCguAccepted,
            Guard.checkIsNotUser,
          ],
          child: VerifyingCodePage(),
        ),
  };
}
