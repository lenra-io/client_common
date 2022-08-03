import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/response_models/cgu_response.dart';
import 'package:client_common/api/response_models/user_accept_cgu_version_response.dart';
import 'package:client_common/api/response_models/user_accepted_latest_cgu_response.dart';

/// All of the CGU requests that can be done on Lenra.
class CguApi {
  static Future<CguResponse> getLatestCgu() => LenraApi.instance.get(
        "/cgu/latest",
        responseMapper: (json, header) => CguResponse.fromJson(json),
      );

  static Future<UserAcceptCguVersionResponse> acceptCgu(int cguId) => LenraApi.instance.post(
        "/cgu/$cguId/accept",
        responseMapper: (json, header) => UserAcceptCguVersionResponse.fromJson(json),
      );

  static Future<UserAcceptedLatestCguResponse> userAcceptedLatestCgu() => LenraApi.instance.get(
        "/cgu/me/accepted_latest",
        responseMapper: (json, header) => UserAcceptedLatestCguResponse.fromJson(json),
      );
}
