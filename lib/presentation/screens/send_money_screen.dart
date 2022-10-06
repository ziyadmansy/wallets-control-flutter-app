import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/user_controller.dart';
import 'package:wallets_control/models/available_wallet_model.dart';
import 'package:wallets_control/models/user_wallet_model.dart';
import 'package:wallets_control/presentation/widgets/wallet_card.dart';
import 'package:wallets_control/shared/shared_core.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final userController = Get.find<UserController>();

  List<UserWalletModel> filteredWallets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedCore.buildAppBar(
        title: 'Send Money',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16,
            ),
            child: SharedCore.buildClickableTextForm(
              hint: 'Money to be sent',
              inputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (amount) {
                // if (double.tryParse(amount!) != null) {
                //   filteredWallets = walletsController.availableWallets
                //       .where((wal) =>
                //           wal.receiveMonthlyLimit >= double.parse(amount))
                //       .toList();
                // } else {
                //   filteredWallets = walletsController.availableWallets;
                // }
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: filteredWallets.isEmpty
                ? const Center(
                    child: Text(
                      'No Wallets Available to send this amount of money.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredWallets.length,
                    itemBuilder: (context, i) {
                      final filteredUserWallet = filteredWallets[i];
                      return WalletCard(
                        userWallet: filteredUserWallet,
                        onDeletePress: null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
