import 'package:client_common/api/application_api.dart';
import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/apps_response.dart';
import 'package:client_common/models/status.dart';
import 'package:flutter/cupertino.dart';

/// The model that manages the store of applications.
class StoreModel extends ChangeNotifier {
  Status<AppsResponse> fetchApplicationsStatus = Status();
  List<AppResponse> applications = [];

  Future<List<AppResponse>> fetchApplications() async {
    var res = await fetchApplicationsStatus.handle(ApplicationApi.getApps, notifyListeners);
    applications = res.apps;
    notifyListeners();
    return res.apps;
  }
}
