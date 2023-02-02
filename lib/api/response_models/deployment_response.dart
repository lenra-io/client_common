import 'package:client_common/api/response_models/api_response.dart';

enum DeploymentStatus { created, pending, failure, success }

class DeploymentResponse extends ApiResponse {
  int id;
  int buildId;
  int applicationId;
  DeploymentStatus status;
  DateTime insertedAt;

  DeploymentResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = DeploymentStatus.values.firstWhere((e) => e.toString() == 'DeploymentStatus.${json["status"]}',
            orElse: () => DeploymentStatus.failure),
        insertedAt = DateTime.parse(json["inserted_at"]),
        buildId = json["build_id"],
        applicationId = json["application_id"];

  @override
  bool operator ==(Object other) {
    return other is DeploymentResponse &&
        other.buildId == buildId &&
        other.id == id &&
        other.status == status &&
        other.insertedAt == insertedAt &&
        other.applicationId == applicationId;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
