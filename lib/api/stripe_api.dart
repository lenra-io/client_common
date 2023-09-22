import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/create_stripe_checkout_request.dart';
import 'package:client_common/api/request_models/create_stripe_customer_request.dart';
import 'package:client_common/api/response_models/get_stripe_subscriptions_response.dart';

class StripeApi {
  static Future<String> createCustomer(CreateStripeCustomerRequest body) => LenraApi.instance.post(
        "/stripe/customers",
        body: body,
        responseMapper: (json, header) => json as String,
      );

  static Future<GetStripeSubscriptionsResponse> getSubscriptions(int appId) => LenraApi.instance.get(
        "/stripe/subscriptions?id=$appId",
        responseMapper: (json, header) => GetStripeSubscriptionsResponse.fromJson(json),
      );

  static Future<String> createCheckout(CreateStripeCheckoutRequest body) => LenraApi.instance.post(
        "/stripe/customers",
        body: body,
        responseMapper: (json, header) => json as String,
      );
}
