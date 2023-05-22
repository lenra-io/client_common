import 'package:client_common/api/response_models/api_response.dart';
import 'package:client_common/utils/color_parser.dart';
import 'package:flutter/material.dart';

class AppResponse extends ApiResponse {
  int? id;
  String? name;
  String? serviceName;
  IconData? icon;
  Color? color;
  String? repository;
  String? repositoryBranch;

  AppResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        serviceName = json["service_name"],
        icon = IconData(json["icon"], fontFamily: 'MaterialIcons'),
        color = json["color"].toString().parseColor(),
        repository = json["repository"],
        repositoryBranch = json["repository_branch"];
}
