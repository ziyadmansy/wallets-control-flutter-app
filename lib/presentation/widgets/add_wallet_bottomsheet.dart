import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/user_controller.dart';
import 'package:wallets_control/models/wallet_brand_model.dart';
import 'package:wallets_control/shared/shared_core.dart';

class AddWalletBottomSheet extends StatefulWidget {
  const AddWalletBottomSheet({super.key});

  @override
  State<AddWalletBottomSheet> createState() => _AddWalletBottomSheetState();
}

class _AddWalletBottomSheetState extends State<AddWalletBottomSheet> {
  bool isLoadingSubmit = false;

  final userController = Get.find<UserController>();

  final phoneTextController = TextEditingController();
  final balanceController = TextEditingController();

  WalletBrandModel? selectedWalletBrand;

  final formKey = GlobalKey<FormState>();

  Future<void> submitNewWallet() async {
    final isValid = formKey.currentState?.validate();
    if (isValid ?? false) {
      setState(() {
        isLoadingSubmit = true;
      });
      await userController.addUserWallet(
        walletId: selectedWalletBrand!.id,
        phone: phoneTextController.text,
        balance: balanceController.text,
      );
      await userController.getUserProfile();
      setState(() {
        isLoadingSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Add Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SharedCore.buildClickableTextForm(
              controller: phoneTextController,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.phone,
              hint: 'ex: 01234567890',
              label: 'Phone Number',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your phone number';
                } else if (value.length != 11) {
                  return 'Enter a valid 11-digit number';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            SharedCore.buildClickableTextForm(
              controller: balanceController,
              textInputAction: TextInputAction.done,
              inputType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              hint: 'ex: 1000',
              label: 'Balance',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your balance';
                } else if (double.tryParse(value) == null) {
                  return 'Enter a valid balance number';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            SharedCore.buildDropDownSearch<WalletBrandModel?>(
              context: context,
              selectedItem: selectedWalletBrand,
              items: userController.availableWallets,
              onChanged: (wallet) {
                selectedWalletBrand = wallet;
              },
              itemAsString: (walletBrand) {
                return walletBrand?.name ?? '';
              },
              compareFn:
                  (WalletBrandModel? prevWallet, WalletBrandModel? newWallet) {
                return prevWallet?.id == newWallet?.id;
              },
              filterFn: (wallet, query) {
                return wallet?.name.toLowerCase().contains(query) ?? false;
              },
              onValidate: (value) {
                if (value == null) {
                  return 'Choose Wallet';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: Get.width,
              child: SharedCore.buildRoundedElevatedButton(
                btnChild: isLoadingSubmit
                    ? SharedCore.buildLoaderIndicator()
                    : Text('Submit'),
                onPress: isLoadingSubmit ? null : submitNewWallet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
