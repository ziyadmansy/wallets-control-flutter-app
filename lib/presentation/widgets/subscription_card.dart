import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/wallet_brand_model.dart';
import 'package:wallets_control/models/subscription_model.dart';
import 'package:wallets_control/models/user_wallet_model.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionModel subModel;

  const SubscriptionCard({required this.subModel});

  Container buildRoundedContainer({
    required String title,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            title,
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildWalletCardListTileRow({
    required String title,
    required String value,
  }) {
    return ListTile(
      title: Text(
        title,
      ),
      trailing: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          value,
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
      // color: wallet.color,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'عرض العروض',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildRoundedContainer(
                  title: 'Start',
                  value: subModel.startDate,
                ),
                buildRoundedContainer(
                  title: 'End',
                  value: subModel.endDate,
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            buildWalletCardListTileRow(
              title: 'Amount',
              value: '100',
            ),
            const Divider(
              color: Colors.white,
            ),
            buildWalletCardListTileRow(
              title: 'Expiry',
              value: '3',
            ),
            const Divider(
              color: Colors.white,
            ),
            buildWalletCardListTileRow(
              title: 'Wallets Limit',
              value: '3',
            ),
          ],
        ),
      ),
    );
  }
}
