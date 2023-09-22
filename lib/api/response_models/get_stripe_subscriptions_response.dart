import 'package:client_common/api/response_models/api_response.dart';

class GetStripeSubscriptionsResponse extends ApiResponse {
  String customerId;

  GetStripeSubscriptionsResponse.fromJson(Map<String, dynamic> json) : customerId = json as String;
}
