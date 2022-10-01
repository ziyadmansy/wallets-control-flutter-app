import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:wallets_control/models/device_info.dart';
import 'package:wallets_control/shared/constants.dart';

class DeviceInfoController extends GetxController {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<DeviceInfoModel> getDeviceInfoData() async {
    DeviceInfoModel deviceInfoModel;

    try {
      if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;

        deviceInfoModel = DeviceInfoModel(
          id: iosInfo.identifierForVendor,
          os: iosOSText,
          osVersion: '${iosInfo.systemVersion}',
          model: '${iosInfo.name} ${iosInfo.model}',
        );
      } else {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        const androidIdPlugin = AndroidId();

        deviceInfoModel = DeviceInfoModel(
          id: await androidIdPlugin.getId(),
          os: androidOSText,
          osVersion:
              '${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})',
          model: '${androidInfo.manufacturer} ${androidInfo.model}',
        );
      }

      return deviceInfoModel;
    } catch (error) {
      print('Send Device Info catch error: ' + error.toString());
      rethrow;
    }
  }
}
