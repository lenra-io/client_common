import 'package:http/http.dart' as http;
import 'package:phoenix_wings/phoenix_wings.dart';

PhoenixSocket createPhoenixSocket(
  String endpoint,
  Map<String, String> params,
) =>
    PhoenixSocket(
      endpoint,
      socketOptions: PhoenixSocketOptions(params: params),
    );

http.Client createHttpClient() => http.Client();

String getServerUrl() => "https://app.lenra.io";
