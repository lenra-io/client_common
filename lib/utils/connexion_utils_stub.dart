import 'package:http/http.dart' as http;
import 'package:phoenix_wings/phoenix_wings.dart';

PhoenixSocket createPhoenixSocket(
        String endpoint, Map<String, String> params) =>
    throw UnsupportedError('Cannot get server url');

http.Client createHttpClient() =>
    throw UnsupportedError('this should not happend.');

String getServerUrl() => throw UnsupportedError('Cannot get server url');
