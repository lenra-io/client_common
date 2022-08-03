import 'package:client_common/api/response_models/api_response.dart';

class CguResponse extends ApiResponse {
  int id;
  String path;
  String hash;
  int version;

  CguResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        path = json["path"],
        hash = json["hash"],
        version = json["version"];
}
