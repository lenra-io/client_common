import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/api/response_models/app_response.dart';

class UpdateAppResponse extends ApiResponse {
  AppResponse appResponse;

  UpdateAppResponse.fromJson(Map<String, dynamic> json) : appResponse = AppResponse.fromJson(json);
}
