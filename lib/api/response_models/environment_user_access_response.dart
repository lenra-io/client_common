import 'package:client_common/api/response_models/api_response.dart';

class EnvironmentUserAccessResponse extends ApiResponse {
  int? userId;
  int environmentId;
  String? email;

  EnvironmentUserAccessResponse.fromJson(Map<String, dynamic> json)
      : userId = json["user_id"],
        environmentId = json["environment_id"],
        email = json["email"];
}
