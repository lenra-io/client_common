import 'dart:convert';

import 'package:client_common/api/response_models/api_error.dart';
import 'package:client_common/config/config.dart';
import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

typedef ResponseMapper<T> = T Function(dynamic json, dynamic header);

/// The abstract LenraBaseHttpClient class is the base class for all Lenra HTTP clients.
///
/// It provides the basic methods to send HTTP requests and to parse the response.
abstract class LenraBaseHttpClient {
  final http.Client client;
  final RegExp refreshTokenRegExp = RegExp(r'guardian_default_token=([^;]+)');

  String? extractRefreshToken(String cookieString) {
    final match = refreshTokenRegExp.firstMatch(cookieString);
    if (match != null) {
      return match.group(1);
    } else {
      return null;
    }
  }

  LenraBaseHttpClient() : client = createHttpClient();

  String get _apiUrl;
  Map<String, String> get _headers;

  String? encodeBody(dynamic body) {
    return body != null ? json.encode(body) : null;
  }

  Future<T> _handleResponse<T>(
    Future<http.Response> futureReponse, {
    ResponseMapper<T>? responseMapper,
  }) async {
    ResponseMapper<T> mapper = responseMapper ?? (e, h) => e;
    http.Response response;

    try {
      response = await futureReponse;
    } catch (e) {
      throw ApiError.connexionRefusedError();
    }

    dynamic body = json.decode(response.body);

    if (response.statusCode >= 400 && response.statusCode < 600) {
      throw ApiError.fromJson(body);
    } else {
      final cookieString = response.headers['set-cookie'];
      if (cookieString != null) {
        final refreshToken = extractRefreshToken(response.headers['set-cookie']!);
        if (refreshToken != null) {
          final storage = FlutterSecureStorage();
          storage.write(key: "refreshToken", value: refreshToken);
        }
      }

      return mapper(body, response.headers);
    }
  }

  Future<T> get<T>(String url, {ResponseMapper<T>? responseMapper}) {
    Future<http.Response> response = client.get(
      Uri.parse("$_apiUrl$url"),
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> post<T>(String url, {ResponseMapper<T>? responseMapper, dynamic body, Map<String, String>? headers}) {
    if (headers != null) {
      headers.addAll(_headers);
    }
    print("API Call POST on $_apiUrl$url");
    Future<http.Response> response = client.post(
      Uri.parse("$_apiUrl$url"),
      body: encodeBody(body),
      headers: headers ?? _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> put<T>(String url, {ResponseMapper<T>? responseMapper, dynamic body}) {
    Future<http.Response> response = client.put(
      Uri.parse("$_apiUrl$url"),
      body: encodeBody(body),
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> patch<T>(String url, {ResponseMapper<T>? responseMapper, dynamic body}) {
    Future<http.Response> response = client.patch(
      Uri.parse("$_apiUrl$url"),
      body: encodeBody(body),
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> delete<T>(String url, {ResponseMapper<T>? responseMapper, dynamic body}) {
    Future<http.Response> response = client.delete(
      Uri.parse("$_apiUrl$url"),
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }
}

/// The LenraApi class that is used to send HTTP requests to Lenra api under the `/api` endpoint.
class LenraApi extends LenraBaseHttpClient {
  static final LenraApi _instance = LenraApi();
  static LenraApi get instance => _instance;

  String? _token;
  set token(String? newToken) => _token = newToken;

  @override
  String get _apiUrl {
    return "${Config.instance.httpEndpoint}/api";
  }

  @override
  Map<String, String> get _headers {
    return {"Content-Type": "application/json", "Authorization": "Bearer $_token"};
  }
}

/// The LenraAuth class that is used to send HTTP requests to Lenra api under the `/auth` endpoint.
///
/// It is used to authenticate the user and to get the user's token.
class LenraAuth extends LenraBaseHttpClient {
  static final LenraAuth _instance = LenraAuth();
  static LenraAuth get instance => _instance;

  @override
  String get _apiUrl {
    return "${Config.instance.httpEndpoint}/auth";
  }

  @override
  Map<String, String> get _headers {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    if (Config.instance.basicAuth.isNotEmpty) {
      headers["Authorization"] = "Basic ${Config.instance.basicAuth}";
    }

    return headers;
  }
}
