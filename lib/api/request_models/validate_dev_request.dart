import 'package:client_common/api/request_models/api_request.dart';

class ValidateDevRequest extends ApiRequest {
  final String code;

  ValidateDevRequest(this.code);

  dynamic toJson() => {
        "code": code,
      };
}
