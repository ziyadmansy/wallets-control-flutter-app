import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/models/plan_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class MessagesController extends GetConnect {
  
  Future<void> submitSmsMsg(
      {required int walletId, required String msg}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      const url = ApiRoutes.smsStore;
      print(url);

      final accessToken = prefs.getString(accessTokenPrefsKey);

      if (accessToken != null) {
        final Response response = await post(
          url,
          json.encode({
            'wallet_id': walletId,
            'message': msg,
          }),
          headers: {
            'Authorization': accessToken,
          },
        );

        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 201) {
          // Success
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
