import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/deployment_response.dart';

class DeploymentsResponse extends ApiResponse {
  List<DeploymentResponse> deployments;

  DeploymentsResponse.fromJson(List<dynamic> json)
      : deployments = json.map<DeploymentResponse>((deployment) => DeploymentResponse.fromJson(deployment)).toList();
}
