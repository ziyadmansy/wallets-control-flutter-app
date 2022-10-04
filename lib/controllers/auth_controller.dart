import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets_control/controllers/firebase_controller.dart';
import 'package:wallets_control/exceptions/auth_exception.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/dialogs.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

import 'device_info_controller.dart';

class AuthController extends GetConnect {
  Rx<String> accessToken = ''.obs;

  Future<void> registerUser({
    required String name,
    required String walletPhone,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      const url = ApiRoutes.register;
      print(url);

      final deviceInfoController = Get.find<DeviceInfoController>();
      final deviceInfoData = await deviceInfoController.getDeviceInfoData();

      final firebaseController = Get.find<FirebaseController>();
      final fcmToken = await firebaseController.getFcmToken();

      String formatedPhone = walletPhone.replaceAll('+', '');
      formatedPhone = formatedPhone.startsWith("0", 0)
          ? formatedPhone
          : formatedPhone.substring(1);

      print('Formated Phone: $formatedPhone');

      final Response response = await post(
        url,
        json.encode({
          'name': name,
          'app_lang': 'en',
          'main_wallet_phone': walletPhone,
          'phone': formatedPhone,
          'fcm_token': fcmToken,
          'uuid': deviceInfoData.id,
          'os': deviceInfoData.os,
          'os_version': deviceInfoData.osVersion,
          'model': deviceInfoData.model,
        }),
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Success - Account Created
        final decodedResponseBody = response.body;
        accessToken.value = 'Bearer ${decodedResponseBody['access_token']}';
        await prefs.setString(accessTokenPrefsKey, accessToken.value);
        Get.snackbar('Success!', 'Account Created Successfully');
      } else {
        throw AuthException('Error - ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> loginUser({required String phone}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      const url = ApiRoutes.login;
      print(url);

      String formatedPhone = phone.replaceAll('+', '');
      formatedPhone = formatedPhone.startsWith("0", 0)
          ? formatedPhone
          : formatedPhone.substring(1);

      print('Formated Phone: $formatedPhone');

      final Response response = await post(
        url,
        json.encode({
          'phone': formatedPhone,
          'password': defaultPassword,
        }),
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Success - Account Created
        final decodedResponseBody = response.body;
        accessToken.value = 'Bearer ${decodedResponseBody['access_token']}';
        await prefs.setString(accessTokenPrefsKey, accessToken.value);
        Get.snackbar('Success!', 'Logged in successfully');
        Get.offNamed(AppRoutes.homeRoute);
      } else {
        throw AuthException('Error - ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      const url = ApiRoutes.logout;
      print(url);

      final Response response = await post(
        url,
        {},
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      final auth = FirebaseAuth.instance;
      accessToken.value = '';
      await prefs.clear();
      await auth.signOut();
      print('Signed out successfully');
      Get.offAllNamed(AppRoutes.loginRoute);
      Get.snackbar('Success!', 'Logged out successfully');
    } catch (e) {
      print(e);
    }
  }
}
