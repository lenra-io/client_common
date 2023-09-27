import 'package:client_common/api/request_models/api_request.dart';

class CreateStripeCheckoutRequest extends ApiRequest {
  int appId;
  String plan;
  String customer;
  String successUrl;
  String cancelUrl;

  CreateStripeCheckoutRequest({
    required this.appId,
    required this.plan,
    required this.customer,
    required this.successUrl,
    required this.cancelUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': appId,
        'plan': plan,
        'customer': customer,
        'success_url': successUrl,
        'cancel_url': cancelUrl,
      };
}
