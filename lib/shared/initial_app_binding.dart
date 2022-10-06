import 'package:get/get.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/controllers/device_info_controller.dart';
import 'package:wallets_control/controllers/firebase_controller.dart';
import 'package:wallets_control/controllers/messages_controller.dart';
import 'package:wallets_control/controllers/plans_controller.dart';
import 'package:wallets_control/controllers/user_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AuthController(),
      permanent: true,
    );
    Get.put(UserController());
    Get.put(DeviceInfoController());
    Get.put(FirebaseController());
    Get.put(PlansController());
    Get.put(MessagesController());
  }
}
