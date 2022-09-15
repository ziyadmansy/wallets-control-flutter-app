import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/wallet.dart';

class WalletsController extends GetxController {
  RxList<WalletModel> wallets = <WalletModel>[
    WalletModel(
      id: 0,
      name: 'Vodafone Cash',
      imgUrl: 'https://logodix.com/logo/349058.png',
      color: Color(0xffE30613),
      number: '01023843232',
      spentBalance: 1000,
      remainingBalance: 500,
      isActivated: true,
    ),
    WalletModel(
      id: 1,
      name: 'Etisalat Cash',
      imgUrl: 'https://logodix.com/logo/497290.png',
      color: Color(0xff78A22F),
      number: '01156892514',
      spentBalance: 500,
      remainingBalance: 1000,
      isActivated: true,
    ),
  ].obs;
}
