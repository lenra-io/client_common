import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/create_stripe_customer_request.dart';
import 'package:client_common/api/response_models/create_stripe_checkout_response.dart';
import 'package:client_common/api/response_models/create_stripe_customer_response.dart';
import 'package:client_common/api/response_models/get_stripe_subscriptions_response.dart';

class StripeApi {
  static Future<CreateStripeCustomerResponse> createCustomer(CreateStripeCustomerRequest body) =>
      LenraApi.instance.post(
        "/stripe/customers",
        body: body,
        responseMapper: (json, header) => CreateStripeCustomerResponse.fromJson(json),
      );

  static Future<GetStripeSubscriptionsResponse> getSubscriptions(String appId) => LenraApi.instance.get(
        "/stripe/subscriptions?app_id=$appId",
        responseMapper: (json, header) => GetStripeSubscriptionsResponse.fromJson(json),
      );

  static Future<CreateStripeCheckoutResponse> createCheckout(CreateStripeCustomerRequest body) =>
      LenraApi.instance.post(
        "/stripe/customers",
        body: body,
        responseMapper: (json, header) => CreateStripeCheckoutResponse.fromJson(json),
      );
}
