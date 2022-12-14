import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/controllers/messages_controller.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        final authController = Get.find<AuthController>();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final savedAccessToken = prefs.getString(accessTokenPrefsKey);
        if (savedAccessToken == null || savedAccessToken.isEmpty) {
          Get.offNamed(AppRoutes.loginRoute);
        } else {
          authController.accessToken.value = savedAccessToken;
          Get.offNamed(AppRoutes.homeRoute);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          appLogoPath,
          width: MediaQuery.of(context).size.width / 1.5,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
