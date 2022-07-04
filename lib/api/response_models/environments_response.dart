import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_response.dart';

class EnvironmentsResponse extends ApiResponse {
  List<EnvironmentResponse> envs;

  EnvironmentsResponse.fromJson(List<dynamic> json)
      : envs = json.map<EnvironmentResponse>((env) => EnvironmentResponse.fromJson(env)).toList();
}
