import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_response.dart';

class EnvironmentsResponse extends ApiResponse {
  List<EnvironmentResponse> envs;

  EnvironmentsResponse.fromJson(Map<String, dynamic> json)
      : envs = json["envs"].map<EnvironmentResponse>((e) => EnvironmentResponse.fromJson(e)).toList();
}
