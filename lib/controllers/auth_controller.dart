import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/firebase_controller.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/dialogs.dart';
import 'package:wallets_control/shared/shared_core.dart';

import 'device_info_controller.dart';

class AuthController extends GetConnect {
  Rx<String> accessToken = ''.obs;

  Future<void> registerUser({
    required String name,
    required String walletPhone,
  }) async {
    try {
      const url = ApiRoutes.register;
      print(url);

      final deviceInfoController = Get.find<DeviceInfoController>();
      final deviceInfoData = await deviceInfoController.getDeviceInfoData();

      final firebaseController = Get.find<FirebaseController>();
      final fcmToken = await firebaseController.getFcmToken();

      final Response response = await post(
        url,
        {
          'name': name,
          'app_lang': 'en',
          'main_wallet_phone': walletPhone,
          'phone': walletPhone,
          'fcm_token': fcmToken,
          'uuid': deviceInfoData.id,
          'os': deviceInfoData.os,
          'os_version': deviceInfoData.osVersion,
          'model': deviceInfoData.model,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Success - Account Created
        Get.snackbar('Success!', 'Account Created Successfully');
      } else {
        Dialogs.showAwesomeDialog(
          context: Get.context!,
          title: 'Error - ${response.statusCode}',
          body: 'Something went wrong, please try again',
          dialogType: DialogType.error,
          onCancel: null,
          onConfirm: () {},
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginUser({required String phone}) async {
    try {
      const url = ApiRoutes.login;
      print(url);

      final Response response = await post(
        url,
        {
          'phone': phone,
          'password': defaultPassword,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Success - Account Created
        Get.snackbar('Success!', 'Logged in successfully');
      } else {
        Dialogs.showAwesomeDialog(
          context: Get.context!,
          title: 'Error - ${response.statusCode}',
          body: 'Something went wrong, please try again',
          dialogType: DialogType.error,
          onCancel: null,
          onConfirm: () {},
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logoutUser() async {
    try {
      const url = ApiRoutes.logout;
      print(url);

      final Response response = await post(
        url,
        {},
        headers: {
          'Authorization': SharedCore.getAccessToken(),
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Success - Account Created
        Get.snackbar('Success!', 'Logged out successfully');
      }
    } catch (e) {
      print(e);
    }
  }
}
