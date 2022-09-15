import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets_control/controllers/auth_controller.dart';
import 'package:wallets_control/exceptions/auth_exception.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/dialogs.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _idNumberFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String phone = '';
  String id = '';

  bool _isLoading = false;

  void _registerUser() async {
    Get.offAndToNamed(AppRoutes.otpRoute);
    // TODO: Edit this after testing
    return;
    final isValid = _formKey.currentState?.validate();
    if (isValid ?? false) {
      _formKey.currentState?.save();
      FocusScope.of(context).unfocus();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final authData = Get.find<AuthController>();
        setState(() {
          _isLoading = true;
        });
        // await authData.memberLogin(phone, id);
        // await authData.sendDeviceInfo(1, '');
        setState(() {
          _isLoading = false;
        });
      } on AuthException catch (error) {
        Dialogs.showAwesomeDialog(
          context: context,
          title: 'Wrong Credentials',
          body: error.message,
          dialogType: DialogType.error,
          onConfirm: () {
            setState(() {
              _isLoading = false;
            });
          },
          onCancel: null,
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
                  'Register',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SharedCore.buildClickableTextForm(
                  hint: 'Phone Number',
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_idNumberFocusNode);
                  },
                  onValidate: (text) {
                    if (text?.isEmpty ?? true) {
                      return 'Mobile number missing';
                    } else if (text?.length != 11) {
                      return 'Enter a valid mobile number';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (text) {
                    phone = text!;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                SharedCore.buildClickableTextForm(
                  hint: 'Password',
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  isObscure: true,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_idNumberFocusNode);
                  },
                  onValidate: (text) {
                    if (text?.isEmpty ?? true) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (text) {
                    // phone = text!;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SharedCore.buildRoundedElevatedButton(
                    btnText: 'Register',
                    onPress: _isLoading ? null : _registerUser,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SharedCore.buildTextButton(
                  btnText: 'Already a user? Login here',
                  onPress: () {
                    Get.offAndToNamed(AppRoutes.loginRoute);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
