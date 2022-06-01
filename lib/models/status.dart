import 'dart:async';

import 'package:client_common/api/response_models/api_errors.dart';
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

  ApiErrors? _errors;
  ApiErrors? get errors => _errors;

  T? _cachedData;
  Future<T>? _currentFuture;
  //List<Completer<T>> _listeners = [];

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
      _errors = null;
      notifyListeners();
      _cachedData = await _currentFuture;
      _requestStatus = RequestStatus.done;
      // _listeners.forEach((c) {
      //   c.complete(this._cachedData);
      // });
      // _listeners.clear();
      return _cachedData!;
    } on ApiErrors catch (errors) {
      _requestStatus = RequestStatus.error;
      _errors = errors;
      // _listeners.forEach((c) {
      //   c.completeError(errors);
      // });
      // _listeners.clear();
      notifyListeners();
      return Future<T>.error(errors);
    } catch (e) {
      debugPrint("Error: $e");
      return Future.error(e.toString());
    }
  }

  /*Future<T> wait() {
    if (this.isDone()) return Future.value(this._cachedData);
    if (this.hasError()) return Future.error(this._errors);
    var completer = Completer<T>();
    _listeners.add(completer);
    return completer.future;
  }*/
}