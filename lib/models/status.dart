import 'dart:async';

import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/cupertino.dart';

enum RequestStatus {
  none,
  fetching,
  done,
  error,
}

class Status<T> {
  // Set this to true prevent the request to redo if the data is already fetched (unless forced).
  bool hasCache;
  Status({this.hasCache = false});

  RequestStatus _requestStatus = RequestStatus.none;
  RequestStatus get requestStatus => _requestStatus;

  ApiError? _error;
  ApiError? get error => _error;

  T? _cachedData;
  Future<T>? _currentFuture;

  bool isFetching() => requestStatus == RequestStatus.fetching;
  bool isDone() => requestStatus == RequestStatus.done;
  bool hasError() => requestStatus == RequestStatus.error;
  bool isNone() => requestStatus == RequestStatus.none;

  Future<T> handle(Future<T> Function() futureBuilder, Function() notifyListeners,
      {bool force = false, bool allowParallel = false}) async {
    if (!allowParallel && isFetching() && _currentFuture != null) return _currentFuture!;
    if (hasCache && isDone() && !force) return _cachedData!;
    try {
      _requestStatus = RequestStatus.fetching;
      _currentFuture = futureBuilder();
      _error = null;
      notifyListeners();
      _cachedData = await _currentFuture;
      _requestStatus = RequestStatus.done;
      return _cachedData!;
    } on ApiError catch (error) {
      _requestStatus = RequestStatus.error;
      _error = error;
      notifyListeners();
      return Future<T>.error(error);
    } catch (e) {
      debugPrint("Error: $e");
      return Future.error(e.toString());
    }
  }
}
