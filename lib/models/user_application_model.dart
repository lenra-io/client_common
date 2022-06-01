import 'package:client_common/api/application_api.dart';
import 'package:client_common/api/environment_api.dart';
import 'package:client_common/api/environment_user_access_api.dart';
import 'package:client_common/api/request_models/create_app_request.dart';
import 'package:client_common/api/request_models/create_environment_user_access_request.dart';
import 'package:client_common/api/request_models/update_app_request.dart';
import 'package:client_common/api/request_models/update_environment_request.dart';
import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/apps_response.dart';
import 'package:client_common/api/response_models/create_app_response.dart';
import 'package:client_common/api/response_models/create_environment_user_access_response.dart';
import 'package:client_common/api/response_models/environment_response.dart';
import 'package:client_common/api/response_models/environment_user_accesses_response.dart';
import 'package:client_common/api/response_models/get_main_env_response.dart';
import 'package:client_common/api/response_models/update_app_response.dart';
import 'package:client_common/api/response_models/update_environment_response.dart';
import 'package:client_common/models/status.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class UserApplicationModel extends ChangeNotifier {
  Status<AppsResponse> fetchApplicationsStatus = Status();
  Status<CreateAppResponse> createApplicationStatus = Status();
  Status<UpdateAppResponse> updateApplicationStatus = Status();
  Status<UpdateEnvironmentResponse> updateEnvironmentStatus = Status();
  Status<GetMainEnvResponse> getMainEnvStatus = Status();
  Status<CreateEnvironmentUserAccessResponse> inviteUserStatus = Status();
  Status<EnvironmentUserAccessesResponse> getInvitedUsersStatus = Status();

  EnvironmentResponse? mainEnv;
  List<AppResponse> userApps = [];
  String? currentApp;

  Future<List<AppResponse>> fetchUserApplications() async {
    var res = await fetchApplicationsStatus.handle(
        ApplicationApi.getUserApps, notifyListeners);
    userApps = res.apps;
    notifyListeners();
    return res.apps;
  }

  Future<AppResponse> createApp(String appName, String gitRepository) async {
    var res = await createApplicationStatus.handle(
        () => ApplicationApi.createApp(
              CreateAppRequest(
                color: LenraColorThemeData.lenraFunGreenBase,
                icon: Icons.apps,
                name: appName,
                repository: gitRepository,
              ),
            ),
        notifyListeners);
    userApps.add(res.app);
    notifyListeners();
    return res.app;
  }

  Future<UpdateAppResponse> updateApp(UpdateAppRequest body) async {
    var res = await updateApplicationStatus.handle(
        () => ApplicationApi.updateApp(body), notifyListeners);
    notifyListeners();
    return res;
  }

  Future<GetMainEnvResponse> getMainEnv(int appId) async {
    var res = await getMainEnvStatus.handle(
      () => ApplicationApi.getMainEnv(appId),
      notifyListeners,
    );
    mainEnv = res.mainEnv;
    notifyListeners();
    return res;
  }

  Future<UpdateEnvironmentResponse> updateEnvironment(
      int appId, int envId, UpdateEnvironmentRequest body) async {
    var res = await updateEnvironmentStatus.handle(
      () => EnvironmentApi.updateEnvironment(appId, envId, body),
      notifyListeners,
    );
    mainEnv = res.environmentResponse;
    notifyListeners();
    return res;
  }

  Future<CreateEnvironmentUserAccessResponse> inviteUser(
    int appId,
    int envId,
    CreateEnvironmentUserAccessRequest body,
  ) async {
    var res = await inviteUserStatus.handle(
      () => EnvironmentUserAccessApi.createEnvironmentUserAccess(
          appId, envId, body),
      notifyListeners,
    );

    notifyListeners();
    return res;
  }

  Future<EnvironmentUserAccessesResponse> getInvitedUsers(
      int appId, int envId) async {
    var res = await getInvitedUsersStatus.handle(
      () => EnvironmentUserAccessApi.getEnvironmentUserAccesses(appId, envId),
      notifyListeners,
    );

    notifyListeners();
    return res;
  }

  AppResponse? get selectedApp {
    if (userApps.isEmpty) return null;
    return userApps.last;
  }
}
