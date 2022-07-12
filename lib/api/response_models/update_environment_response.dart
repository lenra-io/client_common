import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/environment_response.dart';

class UpdateEnvironmentResponse extends ApiResponse {
  EnvironmentResponse environmentResponse;

  UpdateEnvironmentResponse.fromJson(Map<String, dynamic> data)
      : environmentResponse = EnvironmentResponse.fromJson(data);
}
