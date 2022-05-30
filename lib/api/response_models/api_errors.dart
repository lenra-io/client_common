import 'dart:collection';

import 'package:client_common/api/response_models/api_error.dart';

class ApiErrors extends ListBase<ApiError> {
  final List<ApiError> _list;

  ApiErrors.connexionRefusedError() : _list = [ApiError.connexionRefusedError()];

  ApiErrors.fromJson(List<dynamic> json)
      : _list = List.from(json.map((e) => ApiError.fromJson(e as Map<String, dynamic>)));

  bool has401() {
    return _list.any((err) => err.is401());
  }

  //////////////////////////
  // List implementation ///
  //////////////////////////

  @override
  set length(int l) {
    _list.length = l;
  }

  @override
  int get length => _list.length;

  @override
  ApiError operator [](int index) => _list[index];

  @override
  void operator []=(int index, ApiError value) {
    _list[index] = value;
  }

  @override
  String toString() {
    return _list.map((e) => e.toString()).join("\n");
  }
}
