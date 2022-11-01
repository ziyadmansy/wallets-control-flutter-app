import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony.dart';
import 'package:wallets_control/controllers/messages_controller.dart';
import 'package:wallets_control/presentation/pages/profile_page.dart';
import 'package:wallets_control/presentation/pages/settings_page.dart';
import 'package:wallets_control/shared/constants.dart';
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
        'title': 'Profile',
        'body': KeepAlivePage(
          child: const ProfilePage(),
        ),
      },
      {
        'title': 'Settings',
        'body': KeepAlivePage(
          child: const SettingsPage(),
        ),
      },
    ];

    getSMSMessages();
  }

  Future<void> getSMSMessages() async {
    final Telephony telephony = Telephony.instance;

    List<SmsMessage> messages = await telephony.getInboxSms(
      columns: [
        SmsColumn.ADDRESS,
        SmsColumn.BODY,
      ],
      filter: SmsFilter.where(SmsColumn.ADDRESS).equals(vodafoneCashAddress),
      // .or(SmsColumn.ADDRESS) // Phase 2 for other wallets
      // .equals("Et-Cash"),
      sortOrder: [
        OrderBy(SmsColumn.DATE_SENT, sort: Sort.ASC),
      ],
    );

    final msgsController = Get.find<MessagesController>();
    await msgsController.submitSmsMsgs(messages);
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
