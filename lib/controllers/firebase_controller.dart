import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  Future<String?> getFcmToken() async {
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      print(deviceToken);
      return deviceToken;
    } catch (e) {
      print(e);
    }
  }
}
