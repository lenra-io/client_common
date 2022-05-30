import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/create_environment_user_access_request.dart';
import 'package:client_common/api/response_models/create_environment_user_access_response.dart';
import 'package:client_common/api/response_models/environment_user_accesses_response.dart';

class EnvironmentUserAccessApi {
  static Future<CreateEnvironmentUserAccessResponse> createEnvironmentUserAccess(
    int appId,
    int envId,
    CreateEnvironmentUserAccessRequest body,
  ) =>
      LenraApi.instance.post(
        "/apps/$appId/environments/$envId/invitations",
        body: body,
        responseMapper: (json) => CreateEnvironmentUserAccessResponse.fromJson(json),
      );

  static Future<EnvironmentUserAccessesResponse> getEnvironmentUserAccesses(
    int appId,
    int envId,
  ) =>
      LenraApi.instance.get(
        "/apps/$appId/environments/$envId/invitations",
        responseMapper: (json) => EnvironmentUserAccessesResponse.fromJson(json),
      );
}
