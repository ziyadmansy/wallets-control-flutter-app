import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/shared/initial_app_binding.dart';
import 'package:wallets_control/shared/routes.dart';

void main() {
  runApp(const WalletsApp());
}

class WalletsApp extends StatelessWidget {
  const WalletsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallets Control',
      getPages: AppRoutes.routes,
      initialBinding: InitialBindings(),
      home: Scaffold(),
    );
  }
}
