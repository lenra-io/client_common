import 'package:client_common/navigator/guard.dart';
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
import 'package:go_router/go_router.dart';

typedef CustomPageBuilder = Widget Function(Map<String, String>);

/// The common navigator which defines routes that are used across Lenra client projects.
///
/// It defines common routes such as authentication routes or cgu routes.
class CommonNavigator {
  static const String homeRoute = "/";
  static const String validationDevRoute = "/validation-dev";

  static GoRoute changeLostPassword = GoRoute(
    name: "change-lost",
    path: "/change-lost",
    redirect: (context, state) => Guard.guards(context, [Guard.checkUnauthenticated]),
    builder: (ctx, state) => ChangeLostPasswordPage(email: state.extra as String),
  );

  static GoRoute lostPassword = GoRoute(
    name: "lost",
    path: "lost",
    redirect: (context, state) => Guard.guards(context, [Guard.checkUnauthenticated]),
    builder: (ctx, state) => RecoveryPage(),
  );

  static GoRoute changePasswordConfirmation = GoRoute(
    name: "change-confirmation",
    path: "/change-confirmation",
    redirect: (context, state) => Guard.guards(context, [Guard.checkUnauthenticated]),
    builder: (ctx, state) => ChangePasswordConfirmationPage(),
  );

  static GoRoute profile = GoRoute(
    name: "profile",
    path: "/profile",
    redirect: (context, state) => Guard.guards(context, [Guard.checkAuthenticated]),
    builder: (ctx, state) => ProfilePage(),
  );

  static GoRoute login = GoRoute(
    name: "login",
    path: "/sign",
    redirect: (context, state) => Guard.guards(context, [Guard.checkUnauthenticated]),
    builder: (ctx, state) => LoginPage(),
    routes: [lostPassword, register],
  );

  static GoRoute register = GoRoute(
    name: "register",
    path: "register",
    redirect: (context, state) => Guard.guards(context, [Guard.checkUnauthenticated]),
    builder: (ctx, state) => RegisterPage(),
  );

  static GoRoute cgu = GoRoute(
    name: "cgu",
    path: "/cgu",
    redirect: (context, state) => Guard.guards(context, [Guard.checkAuthenticated]),
    builder: (ctx, state) => CguPage(),
    routes: [
      cguFR,
    ],
  );

  static GoRoute cguFR = GoRoute(
    name: "cgu-fr",
    path: "fr",
    redirect: (context, state) => Guard.guards(context, [Guard.checkAuthenticated]),
    builder: (ctx, state) => CguPageFr(),
  );

  static GoRoute userValidation = GoRoute(
    name: "validation-user",
    path: "/validation-user",
    redirect: (context, state) => Guard.guards(context, [
      Guard.checkAuthenticated,
      Guard.checkCguAccepted,
      Guard.checkIsNotUser,
    ]),
    builder: (ctx, state) => VerifyingCodePage(),
  );

  static List<RouteBase> authRoutes = [
    changeLostPassword,
    changePasswordConfirmation,
    profile,
    login,
    cgu,
    userValidation,
  ];

  // static ShellRoute authRoutes = ShellRoute(
  //   builder: (context, state, child) => child,
  //   routes: [
  //     changeLostPassword,
  //     changePasswordConfirmation,
  //     profile,
  //     login,
  //     cgu,
  //     userValidation,
  //   ],
  // );

  static void pop(BuildContext context) {
    GoRouter.of(context).pop();
  }

  static void go(BuildContext context, GoRoute route,
      {Map<String, String> params = const <String, String>{}, Object? extra}) {
    GoRouter.of(context).goNamed(route.name!, params: params, extra: extra);
  }

  static void goPath(BuildContext context, String path,
      {Map<String, String> params = const <String, String>{}, Object? extra}) {
    GoRouter.of(context).go(path, extra: extra);
  }

  static bool isCurrent(BuildContext context, RouteBase route) {
    if (route is GoRoute) {
      return GoRouterState.of(context).fullpath == route.path;
    }
    return route.routes.any((subRoute) => CommonNavigator.isCurrent(context, subRoute));
  }

  static String currentLocation(BuildContext context) {
    return GoRouterState.of(context).location;
  }
}
