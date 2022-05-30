import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/models/socket_model.dart';
import 'package:client_common/socket/lenra_channel.dart';
import 'package:flutter/widgets.dart';
import 'package:lenra_ui_runner/components/events/event.dart';

class ChannelModel extends ChangeNotifier {
  LenraChannel? channel;
  bool hasError = false;
  bool _isInitialized = false;
  ApiErrors? errors;
  late SocketModel socketModel;

  ChannelModel({required this.socketModel});

  bool get isInitialized {
    return _isInitialized;
  }

  set isInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  void createChannel(String appName) {
    channel = socketModel.channel("app", {"app": appName});

    channel!.onError((response) {
      hasError = true;
      isInitialized = true;
      errors = ApiErrors.fromJson(response!["reason"]);
      notifyListeners();
    });
  }

  ChannelModel update(SocketModel socketModel) {
    this.socketModel = socketModel;

    return this;
  }

  bool handleNotifications(Event notification) {
    channel!.send('run', notification.toMap());
    return true;
  }

  void close() {
    channel!.close();
  }
}
