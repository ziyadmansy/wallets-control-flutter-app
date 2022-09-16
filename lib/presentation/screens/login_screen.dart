import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void _loginMember() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid ?? false) {
      _formKey.currentState?.save();
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          _isLoading = true;
        });

        FirebaseAuth auth = FirebaseAuth.instance;

        await auth.verifyPhoneNumber(
          phoneNumber: '+2$phone',
          verificationCompleted: (PhoneAuthCredential credential) async {
            print('verificationCompleted');
            print(credential.asMap());

            await auth.signInWithCredential(credential);

            Get.offAndToNamed(AppRoutes.homeRoute);
          },
          verificationFailed: (FirebaseAuthException e) {
            print('verificationFailed');
            print(e.message);
            print(e.code);
            Dialogs.showAwesomeDialog(
              context: context,
              title: 'Wrong Credentials(${e.message})',
              body: 'Wrong pin, please try again',
              dialogType: DialogType.error,
              onConfirm: () {
                setState(() {
                  _isLoading = false;
                });
              },
              onCancel: null,
            );
          },
          codeSent: (String verificationId, int? resendToken) async {
            print('Code Sent - verificationId: $verificationId');

            setState(() {
              _isLoading = false;
            });

            final String otp = await Get.toNamed(
              AppRoutes.otpRoute,
              arguments: phone,
            );

            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otp,
            );
            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential);

            Get.offAndToNamed(AppRoutes.homeRoute);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } on FirebaseAuthException catch (error) {
        Dialogs.showAwesomeDialog(
          context: context,
          title: 'Wrong Credentials',
          body: error.code,
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
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SharedCore.buildRoundedElevatedButton(
                    btnChild: _isLoading
                        ? SharedCore.buildLoaderIndicator()
                        : Text('Login'),
                    onPress: _isLoading ? null : _loginMember,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SharedCore.buildTextButton(
                  btnText: 'Not a user? Register here',
                  onPress: () {
                    Get.offAndToNamed(AppRoutes.registerRoute);
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
