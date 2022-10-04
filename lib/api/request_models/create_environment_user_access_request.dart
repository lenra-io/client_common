import 'package:client_common/api/request_models/api_request.dart';

class CreateEnvironmentUserAccessRequest extends ApiRequest {
  final String? email;

  CreateEnvironmentUserAccessRequest({
    this.email,
  }) : assert(email != null);

  Map<String, dynamic> toJson() => {
        if (email != null) 'email': email,
      };
}
