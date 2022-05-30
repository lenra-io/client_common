import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_user_access_response.dart';

class EnvironmentUserAccessesResponse extends ApiResponse {
  List<EnvironmentUserAccessResponse> accesses;

  EnvironmentUserAccessesResponse.fromJson(Map<String, dynamic> json)
      : accesses = json["environment_user_accesses"]
            .map<EnvironmentUserAccessResponse>((e) => EnvironmentUserAccessResponse.fromJson(e))
            .toList();
}
