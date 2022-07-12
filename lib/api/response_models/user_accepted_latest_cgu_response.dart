import 'package:client_common/api/response_models/api_response.dart';

class UserAcceptedLatestCguResponse extends ApiResponse {
  bool accepted;

  UserAcceptedLatestCguResponse.fromJson(bool json) : accepted = json;
}
