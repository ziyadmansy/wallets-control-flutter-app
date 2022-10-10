import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/controllers/messages_controller.dart';
import 'package:wallets_control/presentation/screens/home_screen.dart';
import 'package:wallets_control/presentation/screens/login_screen.dart';
import 'package:wallets_control/presentation/screens/splash_screen.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/initial_app_binding.dart';
import 'package:wallets_control/shared/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:wallets_control/shared/shared_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message: ${message.toMap()}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  await validateSMSPermissions();

  runApp(const WalletsApp());
}

Future<void> validateSMSPermissions() async {
  final Telephony telephony = Telephony.instance;

  final isSMSpermissionsGranted = await telephony.requestPhoneAndSmsPermissions;

  print('SMS Permission: $isSMSpermissionsGranted');

  if (isSMSpermissionsGranted ?? false) {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        // Handle message
        print('Foreground SMS Received: ${message.body}');
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }
}

backgroundMessageHandler(SmsMessage message) async {
  //Handle background message
  print('Background SMS Received: ${message.body}');
  
  // Gets all SMS msgs with filter
  // print(Telephony.backgroundInstance.getInboxSms());

  // final msgsController = Get.find<MessagesController>();
  // await msgsController.submitSmsMsg(walletId: 0, msg: message.body ?? '');
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.toMap()}");
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
      home: SplashScreen(),
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor,
        ),
      ),
    );
  }
}
