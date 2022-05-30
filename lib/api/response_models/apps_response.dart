import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/app_response.dart';

class AppsResponse extends ApiResponse {
  List<AppResponse> apps;

  AppsResponse.fromJson(Map<String, dynamic> json)
      : apps = json["apps"].map<AppResponse>((e) => AppResponse.fromJson(e)).toList();
}
