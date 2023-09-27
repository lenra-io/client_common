import 'package:client_common/api/request_models/api_request.dart';

class CreateStripeCustomerRequest extends ApiRequest {
  final String email;

  CreateStripeCustomerRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
