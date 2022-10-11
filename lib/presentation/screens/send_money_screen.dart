import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/user_controller.dart';
import 'package:wallets_control/enums/send_receive_enum.dart';
import 'package:wallets_control/models/wallet_brand_model.dart';
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

  void filterQueryMoneyAmount(String? amount) {
    print(amount);
    if (amount != null && double.tryParse(amount) != null) {
      if (userController.sendReceiveMoney.value == SendReceive.send) {
        print('Send: true');
        final allowedSentMoney = userController.userProfile.value.wallets
            .where((wal) => wal.sendLimitRemaining >= double.parse(amount))
            .toList();
        print(allowedSentMoney);
        filteredWallets = allowedSentMoney;
      } else {
        print('Receive: true');
        final allowedReceivedMoney = userController.userProfile.value.wallets
            .where((wal) => wal.receiveLimitRemaining >= double.parse(amount))
            .toList();
        print(allowedReceivedMoney);
        filteredWallets = allowedReceivedMoney;
      }
    } else {
      filteredWallets = [];
    }

    // To clear wallets after clearing
    if (amount?.isEmpty ?? true) {
      filteredWallets = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: SharedCore.buildClickableTextForm(
              controller: userController.moneyQueryController,
              hint: 'Money sent/received',
              inputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: filterQueryMoneyAmount,
              suffixIcon: IconButton(
                onPressed: () {
                  userController.moneyQueryController.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey,
                ),
              ),
            ),
            toolbarHeight: 100,
          ),
          body: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: SendReceive.send,
                        groupValue: userController.sendReceiveMoney.value,
                        title: Text('Send'),
                        onChanged: (SendReceive? sendReceive) {
                          if (sendReceive != null) {
                            userController.sendReceiveMoney.value = sendReceive;
                            filterQueryMoneyAmount(
                                userController.moneyQueryController.text);
                          }
                        },
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: RadioListTile(
                        value: SendReceive.receive,
                        groupValue: userController.sendReceiveMoney.value,
                        title: Text('Receive'),
                        onChanged: (SendReceive? sendReceive) {
                          if (sendReceive != null) {
                            userController.sendReceiveMoney.value = sendReceive;
                            filterQueryMoneyAmount(
                                userController.moneyQueryController.text);
                          }
                        },
                      ),
                    )
                  ],
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
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          itemCount: filteredWallets.length,
                          itemBuilder: (context, i) {
                            final filteredUserWallet = filteredWallets[i];
                            return SizedBox(
                              height: Get.width,
                              child: WalletCard(
                                userWallet: filteredUserWallet,
                                onDeletePress: null,
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
