import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/shared/routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Subscription Details'),
          leading: Icon(Icons.monetization_on_outlined),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Get.toNamed(AppRoutes.subscriptionRoute);
          },
        ),
        ListTile(
          title: Text('Plans'),
          leading: Icon(Icons.published_with_changes),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Get.toNamed(AppRoutes.plansRoute);
          },
        ),
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.logout),
          onTap: () async {
            final authController = Get.find<AuthController>();

            await authController.logoutUser();
          },
        ),
      ],
    );
  }
}
