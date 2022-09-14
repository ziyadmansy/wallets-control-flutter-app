import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wallets_control/shared/constants.dart';

class Dialogs {
  static Future<void> showAwesomeDialog({
    required BuildContext context,
    required String title,
    required String body,
    required DialogType dialogType,
    required VoidCallback? onCancel,
    required VoidCallback? onConfirm,
    String confirmBtnText = 'Yes',
    String cancelBtnText = 'No',
    Color? btnOkColor,
    bool isDissmissable = true,
  }) async {
    final dialog = AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title,
      desc: body,
      btnCancelOnPress: onCancel,
      btnOkOnPress: onConfirm,
      btnCancelText: cancelBtnText,
      btnOkText: confirmBtnText,
      btnOkColor:
          dialogType == DialogType.error ? redColor : btnOkColor,
      dismissOnTouchOutside: isDissmissable,
      dismissOnBackKeyPress: isDissmissable,
    );

    await dialog.show();
  }
}