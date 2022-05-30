import 'package:client_common/api/response_models/api_response.dart';

class EnvironmentResponse extends ApiResponse {
  int id;
  String name;
  bool isEphemeral;
  bool isPublic;

  EnvironmentResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        isEphemeral = json["is_ephemeral"],
        isPublic = json["is_public"];
}
