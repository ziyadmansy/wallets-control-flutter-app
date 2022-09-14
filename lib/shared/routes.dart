import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String qiblaMapRoute = '/qiblaMap';
  static const String quranArabicRoute = '/quranArabic';
  static const String quranSplashRoute = '/quranArabicSplashScreen';
  static const String categoryItemsRoute = '/categoryItemsScreen';
  static const String categoryItemDetailsRoute = '/categoryItemDetailsScreen';

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.qiblaMapRoute,
      page: () => Container(),
    ),
  ];
}
