import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallets_control/presentation/pages/profile_page.dart';
import 'package:wallets_control/presentation/pages/settings_page.dart';
import 'package:wallets_control/presentation/pages/wallets_page.dart';
import 'package:wallets_control/shared/keep_alive.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomNav = 0;
  List<Map<String, Object>> _bottomNavItems = [];

  @override
  void initState() {
    super.initState();
    _bottomNavItems = [
      {
        'title': 'Wallets',
        'body': KeepAlivePage(
          child: const WalletsPage(),
        ),
      },
      {
        'title': 'Settings',
        'body': KeepAlivePage(
          child: const SettingsPage(),
        ),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedCore.buildAppBar(
        title: _bottomNavItems[_selectedBottomNav]['title'] as String,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(22),
            ),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          // CRITICAL ↓ a solid color here destroys FAB notch. Use alpha 0!
          backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
          currentIndex: _selectedBottomNav,
          onTap: (selectedItem) {
            setState(() {
              _selectedBottomNav = selectedItem;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: _bottomNavItems[0]['title'] as String?,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              label: _bottomNavItems[1]['title'] as String?,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.sendMoneyRoute);
        },
        child: const Icon(
          Icons.filter_alt,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _bottomNavItems[_selectedBottomNav]['body'] as Widget?,
    );
  }
}
