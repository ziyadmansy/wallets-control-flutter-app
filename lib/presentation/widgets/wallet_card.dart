import 'package:flutter/material.dart';
import 'package:wallets_control/models/wallet.dart';
import 'package:wallets_control/shared/constants.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
            SizedBox(
              height: 16,
            ),
            Text(
              wallet.number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24,
                letterSpacing: 8,
              ),
            ),
            Divider(
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
    );
  }
}
