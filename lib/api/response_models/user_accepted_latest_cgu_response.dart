import 'package:client_common/api/response_models/api_response.dart';

class UserAcceptedLatestCguResponse extends ApiResponse {
  bool accepted;

  UserAcceptedLatestCguResponse.fromJson(Map<String, dynamic> json) : accepted = json["accepted"];
}
