import 'package:client_common/api/request_models/api_request.dart';

class UpdateEnvironmentRequest extends ApiRequest {
  final String? name;
  final bool? isEphemeral;
  final bool? isPublic;

  UpdateEnvironmentRequest({this.name, this.isEphemeral, this.isPublic});

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name!,
        if (isEphemeral != null) 'is_ephemeral': isEphemeral!,
        if (isPublic != null) 'is_public': isPublic!,
      };
}
