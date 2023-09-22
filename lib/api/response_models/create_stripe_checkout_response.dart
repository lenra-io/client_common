import 'package:client_common/api/response_models/api_response.dart';

class CreateStripeCheckoutResponse extends ApiResponse {
  String sessionId;

  CreateStripeCheckoutResponse.fromJson(Map<String, dynamic> json) : sessionId = json as String;
}
