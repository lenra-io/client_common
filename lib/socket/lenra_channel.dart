library socket;

import 'package:phoenix_wings/phoenix_wings.dart';

class LenraChannel {
  late PhoenixChannel _channel;
  final List<dynamic Function(Map<dynamic, dynamic>?)> _errorCallbacks = [];
  LenraChannel(PhoenixSocket socket, String channelName, Map<String, dynamic> params) {
    _channel = socket.channel(channelName, params);
    _channel.join()?.receive("error", (Map<dynamic, dynamic>? response) {
      for (var c in _errorCallbacks) {
        c(response);
      }
    });
  }

  void close() {
    _channel.off("ui");
    _channel.off("patchUi");
    _channel.off("error");
    _channel.leave();
  }

  void onUi(void Function(Map<dynamic, dynamic>) callback) {
    _channel.on("ui", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
  }

  void onPatchUi(void Function(Map<dynamic, dynamic>) callback) {
    _channel.on("patchUi", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
  }

  void onAppError(void Function(Map<dynamic, dynamic>) callback) {
    _channel.on("error", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
  }

  void onError(dynamic Function(Map<dynamic, dynamic>?) callback) {
    _errorCallbacks.add(callback);
  }

  void send(String event, dynamic data) {
    _channel.push(event: event, payload: data as Map<dynamic, dynamic>);
  }
}
