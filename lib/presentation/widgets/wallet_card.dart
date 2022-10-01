import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/wallet.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/routes.dart';

class WalletCard extends StatelessWidget {
  final WalletModel wallet;

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
      color: wallet.color,
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
                        wallet.imgUrl,
                        height: 75,
                        width: 75,
                      ),
                    ),
                  ),
                  Text(
                    wallet.name,
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
                      text:
                          wallet.number.substring(0, wallet.number.length - 4),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        letterSpacing: 8,
                      ),
                    ),
                    TextSpan(
                      text: wallet.number.substring(wallet.number.length - 4),
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
              buildWalletCardListTileRow(
                title: 'Spent Balance',
                value: wallet.spentBalance,
              ),
              buildWalletCardListTileRow(
                title: 'Remaining Balance',
                value: wallet.remainingBalance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
