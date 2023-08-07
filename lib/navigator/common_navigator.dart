import 'package:client_common/views/auth/oauth_page.dart';
import 'package:client_common/views/profile/change_lost_password_page.dart';
import 'package:client_common/views/profile/change_password_confirmation_page.dart';
import 'package:client_common/views/profile/recovery_page.dart';
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
    builder: (ctx, state) => ChangeLostPasswordPage(email: state.extra as String),
  );

  static GoRoute lostPassword = GoRoute(
    name: "lost",
    path: "/lost",
    builder: (ctx, state) => RecoveryPage(),
  );

  static GoRoute changePasswordConfirmation = GoRoute(
    name: "change-confirmation",
    path: "/change-confirmation",
    builder: (ctx, state) => ChangePasswordConfirmationPage(),
  );

  static GoRoute oauth = GoRoute(
    name: "oauth",
    path: "/oauth",
    builder: (ctx, state) => OAuthPage(),
  );

  static ShellRoute authRoutes = ShellRoute(
    builder: (context, state, child) => SafeArea(child: child),
    routes: [
      changeLostPassword,
      changePasswordConfirmation,
      lostPassword,
      oauth,
    ],
  );

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
