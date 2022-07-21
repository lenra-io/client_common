import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/update_environment_request.dart';
import 'package:client_common/api/response_models/update_environment_response.dart';

class EnvironmentApi {
  static Future<UpdateEnvironmentResponse> updateEnvironment(
    int appId,
    int envId,
    UpdateEnvironmentRequest body,
  ) =>
      LenraApi.instance.patch(
        "/apps/$appId/environments/$envId",
        body: body,
        responseMapper: (json, header) => UpdateEnvironmentResponse.fromJson(json),
      );
}
