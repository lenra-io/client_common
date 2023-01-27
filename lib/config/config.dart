import 'dart:core';

import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

enum Application { app, dev }

class Config {
  static final _instance = Config._();
  static Config get instance => _instance;

  final Application application;
  final String httpEndpoint;
  final String wsEndpoint;
  final String basicAuth;
  final String appBaseUrl;

  Config({
    required this.application,
    required this.httpEndpoint,
    required this.wsEndpoint,
    required this.basicAuth,
    required this.appBaseUrl,
  });

  static _() {
    String basicAuth = _computeBasicAuth();
    String httpEndpoint = _computeHttpEndpoint();
    String wsEndpoint = _computeWsEndpoint(httpEndpoint);
    Application application = _computeApplication(httpEndpoint);
    String appBaseUrl = _computeAppBaseUrl(application);
    String sentryDsn = _computeSentryDsn();

    return Config(
        application: application,
        httpEndpoint: httpEndpoint,
        wsEndpoint: wsEndpoint,
        basicAuth: basicAuth,
        appBaseUrl: appBaseUrl,
        sentryDsn: sentryDsn);
  }

  static String _computeHttpEndpoint() {
    String httpEndpoint = const String.fromEnvironment("LENRA_SERVER_URL");

    if (kIsWeb) {
      html.MetaElement? meta = html.document.querySelector('meta[name="lenra-server-url"]') as html.MetaElement?;
      if (meta != null) {
        if (meta.content != '\${LENRA_SERVER_URL}') {
          httpEndpoint = meta.content;
        }
      }
    }

    if (httpEndpoint.isEmpty) {
      httpEndpoint = getServerUrl();
    }
    return httpEndpoint;
  }

  static String _computeAppBaseUrl(Application app) {
    String appBaseUrl = getServerUrl();
    if (app == Application.dev) {
      appBaseUrl = appBaseUrl.replaceFirst("dev", "app");
    }

    appBaseUrl += "/#/app/";
    return appBaseUrl;
  }

  static String _computeBasicAuth() {
    return const String.fromEnvironment("LENRA_BASIC_AUTH");
  }

  static String _computeWsEndpoint(String httpEndpoint) {
    String wsEndpoint = httpEndpoint.replaceFirst(RegExp("^http"), "ws");
    wsEndpoint += "/socket/websocket";
    return wsEndpoint;
  }

  static Application _computeApplication(String httpEndpoint) {
    String appName = const String.fromEnvironment("LENRA_APPLICATION");
    if (appName.isEmpty) {
      if (kIsWeb) {
        appName = Uri.base.host.replaceAllMapped(RegExp("^([^/.]+)([/.].*)?\$"), (match) {
          return match.group(1)!;
        });
      }
    }
    return Application.values.firstWhere((a) => a.toString() == "Application.$appName", orElse: () => Application.app);
  }

  static String _computeSentryDsn() {
    const sentryDsn = String.fromEnvironment('SENTRY_CLIENT_DSN');
    if (kIsWeb) {
      html.MetaElement? meta = html.document.querySelector('meta[name="sentry-client-dsn"]') as html.MetaElement?;
      if (meta != null) {
        if (meta.content != '\${SENTRY_CLIENT_DSN}') {
          return meta.content;
        }
      }
    }
    return sentryDsn;
  }
}
