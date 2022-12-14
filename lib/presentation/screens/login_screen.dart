import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/exceptions/auth_exception.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/dialogs.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idNumberFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String phone = '';

  bool _isLoading = false;

  Future<bool?> validateSMSPermissions() async {
    final Telephony telephony = Telephony.instance;

    return await telephony.requestPhoneAndSmsPermissions;
  }

  void _loginMember() async {
    final isValid = _formKey.currentState?.validate();
    final isSMSPermissionsValid = await validateSMSPermissions();
    if (!(isSMSPermissionsValid ?? false)) {
      Dialogs.showAwesomeDialog(
        context: context,
        title: 'SMS Permission Error',
        body: 'Accept SMS Permissions to continue using the app',
        dialogType: DialogType.error,
        onCancel: null,
        onConfirm: () {},
        confirmBtnText: 'Close',
        btnOkColor: redColor,
      );
      return;
    }

    if (isValid ?? false) {
      _formKey.currentState?.save();
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          _isLoading = true;
        });
        final authController = Get.find<AuthController>();

        // Login User to get access token
        await authController.loginUser(phone: phone);
      } on AuthException catch (e) {
        Dialogs.showAwesomeDialog(
          context: context,
          title: e.message,
          body: 'Something went wrong, please try again',
          dialogType: DialogType.error,
          onCancel: null,
          onConfirm: () {
            setState(() {
              _isLoading = false;
            });
          },
        );
      } catch (error) {
        Dialogs.showAwesomeDialog(
          context: context,
          title: 'Error 404',
          body: 'Check your internet connection then try again',
          dialogType: DialogType.error,
          onConfirm: () {
            setState(() {
              _isLoading = false;
            });
          },
          onCancel: null,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                ),
                Image.asset(
                  appLogoPath,
                  width: MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.fill,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SharedCore.buildClickableTextForm(
                  hint: 'ex: 01022223333',
                  label: 'Wallet Number',
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_idNumberFocusNode);
                  },
                  onValidate: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Wallet number missing';
                    } else if (!text.startsWith('+')) {
                      return 'Wallet number should start with the country code. ex: (+2)';
                    } else if (text.length != 13) {
                      return 'Enter a valid wallet number';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (text) {
                    phone = '+2$text';
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SharedCore.buildRoundedElevatedButton(
                    btnChild: _isLoading
                        ? SharedCore.buildLoaderIndicator()
                        : const Text('Login'),
                    onPress: _isLoading ? null : _loginMember,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SharedCore.buildTextButton(
                  btnText: 'Not a user? Register here',
                  onPress: () {
                    Get.offNamed(AppRoutes.registerRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
