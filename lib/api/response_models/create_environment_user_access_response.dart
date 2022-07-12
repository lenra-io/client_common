import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_user_access_response.dart';

class CreateEnvironmentUserAccessResponse extends ApiResponse {
  EnvironmentUserAccessResponse environmentUserAccessResponse;

  CreateEnvironmentUserAccessResponse.fromJson(Map<String, dynamic> json)
      : environmentUserAccessResponse = EnvironmentUserAccessResponse.fromJson(json);
}
