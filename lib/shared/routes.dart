import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/presentation/screens/home_screen.dart';
import 'package:wallets_control/presentation/screens/login_screen.dart';
import 'package:wallets_control/presentation/screens/otp_screen.dart';
import 'package:wallets_control/presentation/screens/register_screen.dart';

class AppRoutes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String otpRoute = '/otp';

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.loginRoute,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.registerRoute,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.otpRoute,
      page: () => const OtpScreen(),
    ),
  ];
}
