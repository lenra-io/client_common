import 'package:client_common/api/response_models/api_response.dart';

enum BuildStatus { pending, failure, success }

class BuildResponse extends ApiResponse {
  int id;
  int buildNumber;
  BuildStatus status;
  DateTime insertedAt;

  BuildResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = BuildStatus.values
            .firstWhere((e) => e.toString() == 'BuildStatus.' + json["status"], orElse: () => BuildStatus.failure),
        insertedAt = DateTime.parse(json["inserted_at"]),
        buildNumber = json["build_number"];

  @override
  bool operator ==(Object other) {
    return other is BuildResponse &&
        other.buildNumber == buildNumber &&
        other.id == id &&
        other.status == status &&
        other.insertedAt == insertedAt;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
