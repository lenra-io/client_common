import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/build_response.dart';

class BuildsResponse extends ApiResponse {
  List<BuildResponse> builds;

  BuildsResponse.fromJson(List<dynamic> json)
      : builds = json.map<BuildResponse>((build) => BuildResponse.fromJson(build)).toList();
}
