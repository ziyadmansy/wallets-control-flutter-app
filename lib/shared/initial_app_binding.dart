import 'package:get/get.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/controllers/wallets_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(WalletsController());
  }
}
