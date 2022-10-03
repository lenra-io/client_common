import 'package:client_common/api/response_models/api_response.dart';

class AcceptInvitationResponse extends ApiResponse {
  String appName;

  AcceptInvitationResponse.fromJson(Map<String, dynamic> json) : appName = json["app_name"];
}
