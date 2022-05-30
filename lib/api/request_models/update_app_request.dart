import 'package:client_common/api/request_models/api_request.dart';
import 'package:flutter/cupertino.dart';

class UpdateAppRequest extends ApiRequest {
  final int id;
  final String? name;
  final Color? color;
  final IconData? icon;
  final String? repository;
  final String? repositoryBranch;

  UpdateAppRequest({
    required this.id,
    this.name,
    this.color,
    this.icon,
    this.repository,
    this.repositoryBranch,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        if (name != null) 'name': name,
        if (color != null) 'color': color?.value.toRadixString(16),
        if (icon != null) 'icon': icon?.codePoint,
        if (repository != null) 'repository': repository,
        if (repositoryBranch != null) 'repository_branch': repositoryBranch,
      };
}
