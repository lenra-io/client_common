import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_user_access_response.dart';

class EnvironmentUserAccessesResponse extends ApiResponse {
  List<EnvironmentUserAccessResponse> accesses;

  EnvironmentUserAccessesResponse.fromJson(List<dynamic> json)
      : accesses = json
            .map<EnvironmentUserAccessResponse>(
              (access) => EnvironmentUserAccessResponse.fromJson(access),
            )
            .toList();
}
