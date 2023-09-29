import 'package:client_common/api/application_api.dart';
import 'package:client_common/api/response_models/deployment_response.dart';
import 'package:client_common/api/response_models/deployments_response.dart';
import 'package:client_common/models/status.dart';
import 'package:flutter/material.dart';

/// The model that manages the builds.
class DeploymentModel extends ChangeNotifier {
  Map<int, Status<DeploymentsResponse>> fetchDeploymentsStatus = {};

  Map<int, List<DeploymentResponse>> deploymentsByApp = {};

  List<DeploymentResponse> deploymentsForApp(int appId) {
    if (deploymentsByApp.containsKey(appId)) return deploymentsByApp[appId]!;
    return [];
  }

  DeploymentResponse? latestDeploymentForApp(int appId) {
    if (deploymentsByApp.containsKey(appId) && deploymentsByApp[appId]!.isNotEmpty) {
      return deploymentsByApp[appId]!.reduce((a, b) => a.id > b.id ? a : b);
    } else {
      return null;
    }
  }

  Future<List<DeploymentResponse>> fetchDeployments(int appId) async {
    fetchDeploymentsStatus[appId] = Status();
    var res = await fetchDeploymentsStatus[appId]!.handle(() => ApplicationApi.getDeployments(appId), notifyListeners);
    deploymentsByApp[appId] = res.deployments;
    notifyListeners();
    return res.deployments;
  }
}
