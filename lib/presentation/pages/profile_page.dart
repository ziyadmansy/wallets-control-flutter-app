import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/plans_controller.dart';
import 'package:wallets_control/controllers/user_controller.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/shared_core.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    await userController.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => userController.isLoading.value
          ? Center(
              child: SharedCore.buildLoaderIndicator(),
            )
          : SingleChildScrollView(
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
                ],
              ),
            ),
    );
  }
}
