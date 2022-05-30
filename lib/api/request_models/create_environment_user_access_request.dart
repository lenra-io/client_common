import 'package:client_common/api/request_models/api_request.dart';

class CreateEnvironmentUserAccessRequest extends ApiRequest {
  final int? userId;
  final String? email;

  CreateEnvironmentUserAccessRequest({
    this.userId,
    this.email,
  })  : assert(userId != null || email != null),
        assert(userId == null || email == null);

  Map<String, dynamic> toJson() => {
        if (userId != null) 'user_id': userId,
        if (email != null) 'email': email,
      };
}
