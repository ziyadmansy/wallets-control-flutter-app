import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/models/plan_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class MessagesController extends GetConnect {
  Future<void> submitSmsMsg(List<SmsMessage> msgs) async {
    try {
      if (msgs.isEmpty) {
        Get.snackbar('Empty Msgs', 'SMS Messages have no $vodafoneCashAddress');
        return;
      }

      const url = ApiRoutes.smsStore;
      print(url);

      // ex: [Android is always a sweet treat!, ...]
      final messagesBody = msgs.map((msg) => msg.body).toList();

      // ex: 6505551212 (on Android Emulator)
      final messagesWallet = msgs[0].address;

      print(messagesBody);
      print(messagesWallet);

      final Response response = await post(
        url,
        json.encode({
          'wallet_id': messagesWallet,
          'messages': json.encode(messagesBody),
        }),
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Success
      }
      Get.snackbar(
        'SMS Msgs - Code ${response.statusCode}',
        messagesBody.toString(),
        duration: Duration(seconds: 8),
      );
    } catch (e) {
      print(e);
    }
  }
}
