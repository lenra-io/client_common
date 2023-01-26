import 'package:client_common/api/request_models/api_request.dart';

class SetNotifyProviderRequest extends ApiRequest {
  final String system;
  final String endpoint;

  SetNotifyProviderRequest(this.system, this.endpoint);

  Map<String, String> toJson() => {
        'system': system,
        'endpoint': endpoint,
      };
}
