import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/models/plan_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class MessagesController extends GetConnect {
  Future<void> submitSmsMsgs(List<SmsMessage> msgs) async {
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

  Future<void> submitCallLogs(List<CallLogEntry> logs) async {
    try {
      if (logs.isEmpty) {
        Get.snackbar('Empty Logs', 'No new call logs to send');
        return;
      }

      const url = ApiRoutes.callLogs;
      print(url);

      final formattedLogs = logs
          .map((log) => {
                'name': log.name,
                'number': log.number,
                'formatted_number': log.formattedNumber,
                'call_type': log.callType.toString(),
                'duration': log.duration,
                'timestamp': log.timestamp,
                'cached_number_type': log.cachedNumberType,
                'cached_number_label': log.cachedNumberLabel,
                'sim_display_name': log.simDisplayName,
                'phone_account_id': log.phoneAccountId,
              })
          .toList();

      final Response response = await post(
        url,
        json.encode(formattedLogs),
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
        'Call Logs - Code ${response.statusCode}',
        formattedLogs.toString(),
        duration: Duration(seconds: 8),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e);
    }
  }
}
