import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/presentation/screens/home_screen.dart';
import 'package:wallets_control/presentation/screens/login_screen.dart';
import 'package:wallets_control/presentation/screens/otp_screen.dart';
import 'package:wallets_control/presentation/screens/register_screen.dart';
import 'package:wallets_control/presentation/screens/send_money_screen.dart';
import 'package:wallets_control/presentation/screens/subscription_details.dart';
import 'package:wallets_control/presentation/screens/wallet_transactions_screen.dart';

class AppRoutes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String otpRoute = '/otp';
  static const String walletTransactionsRoute = '/walletTransactions';
  static const String sendMoneyRoute = '/sendMoney';
  static const String subscriptionRoute = '/subscription';

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
    GetPage(
      name: AppRoutes.walletTransactionsRoute,
      page: () => const WalletTransactionScreen(),
    ),
    GetPage(
      name: AppRoutes.sendMoneyRoute,
      page: () => const SendMoneyScreen(),
    ),
    GetPage(
      name: AppRoutes.subscriptionRoute,
      page: () => const SubscriptionScreen(),
    ),
  ];
}
