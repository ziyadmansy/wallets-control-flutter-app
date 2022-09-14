import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/wallets_controller.dart';
import 'package:wallets_control/presentation/widgets/wallet_card.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  final walletsController = Get.find<WalletsController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: walletsController.wallets.length,
      itemBuilder: (context, i) {
        final wallet = walletsController.wallets[i];
        return WalletCard(wallet: wallet);
      },
    );
  }
}
