import 'package:client_common/api/response_models/api_response.dart';

class GetStripeSubscriptionsResponse extends ApiResponse {
  List<dynamic>? subscriptions;

  GetStripeSubscriptionsResponse.fromJson(List<dynamic>? json) : subscriptions = json;
}
