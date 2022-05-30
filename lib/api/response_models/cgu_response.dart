import 'package:client_common/api/response_models/api_response.dart';

class CguResponse extends ApiResponse {
  int id;
  String link;
  String hash;
  String version;

  CguResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        link = json["link"],
        hash = json["hash"],
        version = json["version"];
}
