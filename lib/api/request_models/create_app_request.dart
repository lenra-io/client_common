import 'package:client_common/api/request_models/api_request.dart';
import 'package:flutter/cupertino.dart';

class CreateAppRequest extends ApiRequest {
  final String name;
  final String repository;
  final Color color;
  final IconData icon;

  CreateAppRequest({
    required this.name,
    required this.repository,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'repository': repository,
        'color': color.value.toRadixString(16),
        'icon': icon.codePoint,
      };
}
