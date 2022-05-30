// ignore: avoid_web_libraries_in_flutter
import 'dart:js';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:phoenix_wings/html.dart';

PhoenixSocket createPhoenixSocket(
  String endpoint,
  Map<String, String> params,
) =>
    new PhoenixSocket(
      endpoint,
      connectionProvider: PhoenixHtmlConnection.provider,
      socketOptions: new PhoenixSocketOptions(params: params),
    );

http.Client createHttpClient() {
  var client = http.Client();
  if (kIsWeb) {
    (client as BrowserClient).withCredentials = true;
  }
  return client;
}

String getServerUrl() => context['location']['origin'];
