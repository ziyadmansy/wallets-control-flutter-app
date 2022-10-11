import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/enums/send_receive_enum.dart';
import 'package:wallets_control/models/wallet_brand_model.dart';
import 'package:wallets_control/models/profile_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class UserController extends GetConnect {
  Rx<bool> isLoading = false.obs;
  Rx<bool> hasCrashed = false.obs;

  Rx<SendReceive> sendReceiveMoney = SendReceive.send.obs;
  TextEditingController moneyQueryController = TextEditingController();

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
      rethrow;
    }
  }

  Future<void> addUserWallet({
    required int walletId,
    required String phone,
    required String balance,
  }) async {
    try {
      const url = ApiRoutes.addWallet;
      print(url);

      final Response response = await post(
        url,
        json.encode({
          'brand_id': walletId,
          'phone_number': phone,
          'balance': balance,
        }),
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Success!', 'Wallet added successfully');
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

  Future<void> deleteUserWallet(int walletId) async {
    try {
      final url = ApiRoutes.deleteWallet(walletId);
      print(url);

      final Response response = await delete(
        url,
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        userProfile.value.wallets
            .removeWhere((element) => element.id == walletId);
        userProfile.refresh();
        Get.snackbar('Success!', 'Wallet deleted successfully');
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
