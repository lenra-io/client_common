import 'package:client_common/api/response_models/api_response.dart';

class UserAcceptCguVersionResponse extends ApiResponse {
  int userId;
  int cguId;

  UserAcceptCguVersionResponse.fromJson(Map<String, dynamic> json)
      : userId = json["user_id"],
        cguId = json["cgu_id"];
}
