import 'package:client_common/api/cgu_api.dart';
import 'package:client_common/api/response_models/cgu_response.dart';
import 'package:client_common/api/response_models/user_accept_cgu_version_response.dart';
import 'package:client_common/api/response_models/user_accepted_latest_cgu_response.dart';
import 'package:client_common/config/config.dart';
import 'package:client_common/models/status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// The model that manages the CGU.
class CguModel extends ChangeNotifier {
  Future<CguResponse> getLatestCgu() async {
    var res = await Status().handle(() => CguApi.getLatestCgu(), notifyListeners);
    notifyListeners();
    return res;
  }

  Future<UserAcceptCguVersionResponse> acceptCgu(int cguId) async {
    var res = await Status().handle(() => CguApi.acceptCgu(cguId), notifyListeners);
    notifyListeners();
    return res;
  }

  Future<UserAcceptedLatestCguResponse> userAcceptedLatestCgu() async {
    var res = await Status().handle(() => CguApi.userAcceptedLatestCgu(), notifyListeners);
    notifyListeners();
    return res;
  }

  Future<Response> getLatestCguAsMd(language) async {
    var res = await getLatestCgu().then((cgu) {
      return http.get(Uri.parse("${Config.instance.httpEndpoint}/web/cgu/CGU_${language}_${cgu.version}.md"));
    });
    notifyListeners();
    return res;
  }
}
