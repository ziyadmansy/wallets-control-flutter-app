import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallets_control/presentation/screens/home_screen.dart';
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
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message: ${message.toMap()}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const WalletsApp());
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            print('User is currently signed out!');
            return const LoginScreen();
          } else {
            print('User is currently Logged in!');
            return const HomeScreen();
          }
        },
      ),
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
          colorScheme: ColorScheme.fromSeed(
        seedColor: mainColor,
      )),
    );
  }
}
