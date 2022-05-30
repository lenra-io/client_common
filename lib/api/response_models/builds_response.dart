import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/build_response.dart';

class BuildsResponse extends ApiResponse {
  List<BuildResponse> builds;

  BuildsResponse.fromJson(Map<String, dynamic> json)
      : builds = json["builds"].map<BuildResponse>((e) => BuildResponse.fromJson(e)).toList();
}
