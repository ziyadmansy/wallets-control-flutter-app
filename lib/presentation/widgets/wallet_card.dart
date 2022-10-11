import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/wallet_brand_model.dart';
import 'package:wallets_control/models/user_wallet_model.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class WalletCard extends StatelessWidget {
  final UserWalletModel userWallet;
  final VoidCallback? onDeletePress;

  const WalletCard({required this.userWallet, required this.onDeletePress});

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
          value.toStringAsFixed(1),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      color: userWallet.walletBrand.color,
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: () {
          Get.toNamed(AppRoutes.walletTransactionsRoute);
        },
        child: Stack(
          children: [
            if (onDeletePress != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onDeletePress,
                    icon: Icon(
                      Icons.delete,
                      color: redColor,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
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
                            userWallet.walletBrand.imgUrl,
                            height: 50,
                            width: 50,
                            errorBuilder: SharedCore.networkImageError,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          userWallet.walletBrand.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: userWallet.walletNumber.substring(
                                    0, userWallet.walletNumber.length - 4),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  letterSpacing: 8,
                                ),
                              ),
                              TextSpan(
                                text: userWallet.walletNumber.substring(
                                    userWallet.walletNumber.length - 4),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  letterSpacing: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  buildWalletCardListTileRow(
                    title: 'Balance',
                    value: userWallet.balance,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  buildWalletCardListTileRow(
                    title: 'Spent Balance',
                    value: userWallet.sendLimitRemaining,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  buildWalletCardListTileRow(
                    title: 'Remaining Balance',
                    value: userWallet.receiveLimitRemaining,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
