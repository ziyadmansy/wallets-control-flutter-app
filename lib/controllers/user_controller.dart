import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/available_wallet_model.dart';
import 'package:wallets_control/models/profile_model.dart';
import 'package:wallets_control/models/user_wallet_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class UserController extends GetConnect {
  Rx<bool> isLoading = false.obs;

  Rx<ProfileModel> userProfile = ProfileModel(
    id: 0,
    name: '',
    email: '',
    createdAt: '',
    phone: '',
    mainWalletPhone: '',
    appLang: '',
    wallets: [],
  ).obs;

  RxList<AvailableWalletModel> availableWallets = <AvailableWalletModel>[].obs;

  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;

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
        userProfile.value = ProfileModel.fromMap(response.body['user']);

        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getAvailableWallets() async {
    try {
      isLoading.value = true;

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
            .map((wallet) => AvailableWalletModel.fromJson(wallet))
            .toList();

        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
