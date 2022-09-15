import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/presentation/screens/login_screen.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/initial_app_binding.dart';
import 'package:wallets_control/shared/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const LoginScreen(),
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
          colorScheme: ColorScheme.fromSeed(
        seedColor: mainColor,
      )),
    );
  }
}
