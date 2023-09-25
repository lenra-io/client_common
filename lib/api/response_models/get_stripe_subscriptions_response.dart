import 'package:client_common/api/response_models/api_response.dart';

class GetStripeSubscriptionsResponse extends ApiResponse {
  Map<String, dynamic>? subscriptions;

  GetStripeSubscriptionsResponse.fromJson(Map<String, dynamic>? json) : subscriptions = json;
}
