import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/app_response.dart';

class AppsResponse extends ApiResponse {
  List<AppResponse> apps;

  AppsResponse.fromJson(List<dynamic> json) : apps = json.map<AppResponse>((app) => AppResponse.fromJson(app)).toList();
}
