import 'package:client_common/api/application_api.dart';
import 'package:client_common/api/request_models/create_build_request.dart';
import 'package:client_common/api/response_models/build_response.dart';
import 'package:client_common/api/response_models/builds_response.dart';
import 'package:client_common/api/response_models/create_build_response.dart';
import 'package:client_common/models/status.dart';
import 'package:flutter/material.dart';

/// The model that manages the builds.
class BuildModel extends ChangeNotifier {
  Status<BuildsResponse> fetchBuildsStatus = Status();
  Status<CreateBuildResponse> createBuildStatus = Status();

  Map<int, List<BuildResponse>> buildsByApp = {};

  List<BuildResponse> buildsForApp(int appId) {
    if (buildsByApp.containsKey(appId)) return buildsByApp[appId]!;
    return [];
  }

  BuildResponse? latestBuildForApp(int appId) {
    if (buildsByApp.containsKey(appId) && buildsByApp[appId]!.isNotEmpty) {
      return buildsByApp[appId]!.reduce((a, b) => a.buildNumber > b.buildNumber ? a : b);
    } else {
      return null;
    }
  }

  Future<List<BuildResponse>> fetchBuilds(int appId) async {
    var res = await fetchBuildsStatus.handle(() => ApplicationApi.getBuilds(appId), notifyListeners);
    buildsByApp[appId] = res.builds;
    notifyListeners();
    return res.builds;
  }

  Future<BuildResponse> createBuild(int appId) async {
    var res =
        await createBuildStatus.handle(() => ApplicationApi.createBuild(appId, CreateBuildRequest()), notifyListeners);
    buildsForApp(appId).add(res.build);
    notifyListeners();
    return res.build;
  }
}
