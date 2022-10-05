import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/plans_controller.dart';
import 'package:wallets_control/controllers/user_controller.dart';
import 'package:wallets_control/presentation/widgets/add_wallet_bottomsheet.dart';
import 'package:wallets_control/presentation/widgets/subscription_card.dart';
import 'package:wallets_control/presentation/widgets/wallet_card.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoadingAvailWallets = false;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    await userController.getUserProfile();
  }

  Future<void> buildAddWalletBottomSheet() async {
    try {
      setState(() {
        isLoadingAvailWallets = true;
      });
      await userController.getAvailableWallets();
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kBorderRadius),
            topRight: Radius.circular(kBorderRadius),
          ),
        ),
        builder: (context) {
          return AddWalletBottomSheet();
        },
      );
    } catch (e) {
      Get.snackbar(errorMsg, 'Couldn\'t load wallets');
    } finally {
      setState(() {
        isLoadingAvailWallets = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => userController.isLoading.value
          ? Center(
              child: SharedCore.buildLoaderIndicator(),
            )
          : userController.hasCrashed.value
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(errorMsg),
                      SharedCore.buildTextButton(
                        btnText: 'Retry',
                        onPress: getProfileData,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          userController.userProfile.value.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          userController.userProfile.value.phone,
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          userController.userProfile.value.email,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Wallets',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SharedCore.buildRoundedIconElevatedButton(
                                btnText: 'Add Wallet',
                                icon: Icons.add,
                                onPress: isLoadingAvailWallets
                                    ? null
                                    : buildAddWalletBottomSheet,
                              ),
                            ],
                          ),
                        ),
                        userController.userProfile.value.wallets.isEmpty
                            ? SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    'No wallets available',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: Get.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: userController
                                      .userProfile.value.wallets.length,
                                  itemBuilder: (context, i) {
                                    final userWalletItem = userController
                                        .userProfile.value.wallets[i];

                                    return SizedBox(
                                      width: Get.width / 1.25,
                                      child: WalletCard(
                                        userWallet: userWalletItem,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Subscriptions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        userController.userProfile.value.subscriptions.isEmpty
                            ? SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    'No subscriptions available',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: Get.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: userController
                                      .userProfile.value.subscriptions.length,
                                  itemBuilder: (context, i) {
                                    final subItem = userController
                                        .userProfile.value.subscriptions[i];

                                    return SizedBox(
                                      width: Get.width / 1.25,
                                      child: SubscriptionCard(
                                        subModel: subItem,
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
