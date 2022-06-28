import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_response.dart';

class GetMainEnvResponse extends ApiResponse {
  EnvironmentResponse mainEnv;

  GetMainEnvResponse.fromJson(Map<String, dynamic> json) : mainEnv = EnvironmentResponse.fromJson(json);
}
