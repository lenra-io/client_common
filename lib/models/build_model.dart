import 'package:client_common/api/application_api.dart';
import 'package:client_common/api/request_models/create_build_request.dart';
import 'package:client_common/api/response_models/build_response.dart';
import 'package:client_common/api/response_models/builds_response.dart';
import 'package:client_common/api/response_models/create_build_response.dart';
import 'package:client_common/models/status.dart';
import 'package:flutter/material.dart';

/// The model that manages the builds.
class BuildModel extends ChangeNotifier {
  Map<int, Status<BuildsResponse>> fetchBuildsStatus = {};
  Map<int, Status<CreateBuildResponse>> createBuildStatus = {};

  Map<int, List<BuildResponse>> buildsByApp = {};

  List<BuildResponse> buildsForApp(int appId) {
    if (buildsByApp.containsKey(appId)) return buildsByApp[appId]!;
    return [];
  }

  Future<List<BuildResponse>> fetchBuilds(int appId) async {
    fetchBuildsStatus[appId] = Status();
    var res = await fetchBuildsStatus[appId]!.handle(() => ApplicationApi.getBuilds(appId), notifyListeners);
    buildsByApp[appId] = res.builds;
    notifyListeners();
    return res.builds;
  }

  Future<BuildResponse> createBuild(int appId) async {
    createBuildStatus[appId] = Status();
    var res = await createBuildStatus[appId]!
        .handle(() => ApplicationApi.createBuild(appId, CreateBuildRequest()), notifyListeners);
    buildsForApp(appId).add(res.build);
    notifyListeners();
    return res.build;
  }
}
