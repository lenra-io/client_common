import 'package:client_common/api/response_models/api_response.dart';

class CreateStripeCustomerResponse extends ApiResponse {
  String customerId;

  CreateStripeCustomerResponse.fromJson(Map<String, dynamic> json) : customerId = json['customer_id'];
}
