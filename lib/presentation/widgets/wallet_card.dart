import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/available_wallet_model.dart';
import 'package:wallets_control/models/user_wallet_model.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class WalletCard extends StatelessWidget {
  final UserWalletModel wallet;

  const WalletCard({required this.wallet});

  ListTile buildWalletCardListTileRow({
    required String title,
    required double value,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      // color: wallet.color,
      elevation: 8,
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: () {
          Get.toNamed(AppRoutes.walletTransactionsRoute);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'wallet.imgUrl',
                        height: 75,
                        width: 75,
                        errorBuilder: SharedCore.networkImageError,
                      ),
                    ),
                  ),
                  Text(
                    'wallet.name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: wallet.walletNumber
                          .substring(0, wallet.walletNumber.length - 4),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        letterSpacing: 8,
                      ),
                    ),
                    TextSpan(
                      text: wallet.walletNumber
                          .substring(wallet.walletNumber.length - 4),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        letterSpacing: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              // if (wallet.sendMonthlyLimit != null)
              //   buildWalletCardListTileRow(
              //     title: 'Spent Balance',
              //     value: wallet.sendMonthlyLimit!,
              //   ),
              // if (wallet.receiveMonthlyLimit != null)
              //   buildWalletCardListTileRow(
              //     title: 'Remaining Balance',
              //     value: wallet.receiveMonthlyLimit!,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
