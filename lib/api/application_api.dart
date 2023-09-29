import 'package:client_common/api/lenra_http_client.dart';
import 'package:client_common/api/request_models/create_app_request.dart';
import 'package:client_common/api/request_models/create_build_request.dart';
import 'package:client_common/api/request_models/update_app_request.dart';
import 'package:client_common/api/response_models/app_response.dart';
import 'package:client_common/api/response_models/apps_response.dart';
import 'package:client_common/api/response_models/builds_response.dart';
import 'package:client_common/api/response_models/create_app_response.dart';
import 'package:client_common/api/response_models/create_build_response.dart';
import 'package:client_common/api/response_models/deployments_response.dart';
import 'package:client_common/api/response_models/get_main_env_response.dart';
import 'package:client_common/api/response_models/update_app_response.dart';

/// All of the application requests that can be done on Lenra.
class ApplicationApi {
  static Future<AppsResponse> getApps() => LenraApi.instance.get(
        "/apps",
        responseMapper: (json, header) => AppsResponse.fromJson(json),
      );

  static Future<CreateAppResponse> createApp(CreateAppRequest body) => LenraApi.instance.post(
        "/apps",
        body: body,
        responseMapper: (json, header) => CreateAppResponse.fromJson(json),
      );

  static Future<UpdateAppResponse> updateApp(UpdateAppRequest body) => LenraApi.instance.patch(
        "/apps/${body.id}",
        body: body,
        responseMapper: (json, header) => UpdateAppResponse.fromJson(json),
      );

  static Future<BuildsResponse> getBuilds(int appId) => LenraApi.instance.get(
        "/apps/$appId/builds",
        responseMapper: (json, header) => BuildsResponse.fromJson(json),
      );

  static Future<CreateBuildResponse> createBuild(int appId, CreateBuildRequest body) => LenraApi.instance.post(
        "/apps/$appId/builds",
        body: body,
        responseMapper: (json, header) => CreateBuildResponse.fromJson(json),
      );

  static Future<DeploymentsResponse> getDeployments(int appId) => LenraApi.instance.get(
        "/apps/$appId/deployments",
        responseMapper: (json, header) => DeploymentsResponse.fromJson(json),
      );

  static Future<GetMainEnvResponse> getMainEnv(int appId) => LenraApi.instance.get(
        "/apps/$appId/main_environment",
        responseMapper: (json, header) => GetMainEnvResponse.fromJson(json),
      );

  static Future<AppsResponse> getUserApps() => LenraApi.instance.get(
        "/me/apps",
        responseMapper: (json, header) => AppsResponse.fromJson(json),
      );

  static Future<AppsResponse> getAppsUserOpened() => LenraApi.instance.get(
        "/me/opened_apps",
        responseMapper: (json, header) => AppsResponse.fromJson(json),
      );

  static Future<AppResponse> getAppByServiceName(String appServiceName) => LenraApi.instance.get(
        "/apps/$appServiceName",
        responseMapper: (json, header) => AppResponse.fromJson(json),
      );
}
