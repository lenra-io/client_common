import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/accept_invitation_response.dart';
import 'package:client_common/api/request_models/create_environment_user_access_request.dart';
import 'package:client_common/api/response_models/create_environment_user_access_response.dart';
import 'package:client_common/api/response_models/environment_user_access_response.dart';
import 'package:client_common/api/response_models/environment_user_accesses_response.dart';

/// All of the environment user access requests that can be done on Lenra.
class EnvironmentUserAccessApi {
  static Future<CreateEnvironmentUserAccessResponse> createEnvironmentUserAccess(
    int appId,
    int envId,
    CreateEnvironmentUserAccessRequest body,
  ) =>
      LenraApi.instance.post(
        "/apps/$appId/environments/$envId/invitations",
        body: body,
        responseMapper: (json, header) => CreateEnvironmentUserAccessResponse.fromJson(json),
      );

  static Future<EnvironmentUserAccessesResponse> getEnvironmentUserAccesses(
    int appId,
    int envId,
  ) =>
      LenraApi.instance.get(
        "/apps/$appId/environments/$envId/invitations",
        responseMapper: (json, header) => EnvironmentUserAccessesResponse.fromJson(json),
      );

  static Future<EnvironmentUserAccessResponse> getInvitation(String uuid) => LenraApi.instance.get(
        "/apps/invitations/$uuid",
        responseMapper: (json, header) => EnvironmentUserAccessResponse.fromJson(json),
      );

  static Future<AcceptInvitationResponse> acceptInvitation(String uuid) => LenraApi.instance.post(
        "/apps/invitations/$uuid",
        responseMapper: (json, header) => AcceptInvitationResponse.fromJson(json),
      );
}
