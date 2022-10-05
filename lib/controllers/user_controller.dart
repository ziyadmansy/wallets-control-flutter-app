import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/models/available_wallet_model.dart';
import 'package:wallets_control/models/profile_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class UserController extends GetConnect {
  Rx<bool> isLoading = false.obs;
  Rx<bool> hasCrashed = false.obs;

  Rx<ProfileModel> userProfile = ProfileModel(
    id: 0,
    name: '',
    email: '',
    createdAt: '',
    phone: '',
    mainWalletPhone: '',
    appLang: '',
    wallets: [],
    subscriptions: [],
  ).obs;

  RxList<WalletBrandModel> availableWallets = <WalletBrandModel>[].obs;

  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;
      hasCrashed.value = false;

      const url = ApiRoutes.profile;
      print(url);

      final Response response = await get(
        url,
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        userProfile.value = ProfileModel.fromMap(response.body);
        isLoading.value = false;
        hasCrashed.value = false;
      } else if (response.statusCode == unauthenticatedStatusCode) {
        final authController = Get.find<AuthController>();
        await authController.logoutUser();
      } else {
        throw Exception(errorMsg);
      }
    } catch (e) {
      isLoading.value = false;
      hasCrashed.value = true;
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getAvailableWallets() async {
    try {
      const url = ApiRoutes.walletsBrands;
      print(url);

      final Response response = await get(
        url,
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        availableWallets.value = (response.body['data'] as List)
            .map((wallet) => WalletBrandModel.fromMap(wallet))
            .toList();
      } else if (response.statusCode == unauthenticatedStatusCode) {
        final authController = Get.find<AuthController>();
        await authController.logoutUser();
      } else {
        throw Exception(errorMsg);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
