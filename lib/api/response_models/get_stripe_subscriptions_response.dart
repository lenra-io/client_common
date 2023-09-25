import 'package:client_common/api/response_models/api_response.dart';

class GetStripeSubscriptionsResponse extends ApiResponse {
  String startDate;
  String endDate;
  String plan;
  int applicationId;

  GetStripeSubscriptionsResponse.fromJson(Map<String, dynamic> json)
      : startDate = json["start_date"],
        endDate = json["end_date"],
        plan = json["plan"],
        applicationId = json["application_id"];
}
