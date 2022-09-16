import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets_control/shared/constants.dart';
import 'package:wallets_control/shared/dialogs.dart';
import 'package:wallets_control/shared/routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;
  final TextEditingController _pinPutController = TextEditingController();

  String? otpVerificationId;

  Future<void> _sendOtp(String pin) async {
    print("Completed: " + pin);
    try {
      setState(() {
        _isLoading = true;
      });

      FirebaseAuth auth = FirebaseAuth.instance;

      if (otpVerificationId != null) {
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: otpVerificationId!,
          smsCode: pin,
        );
        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);

        Get.offAndToNamed(AppRoutes.homeRoute);
      } else {
        Dialogs.showAwesomeDialog(
          context: context,
          title: 'Wrong Credentials',
          body: 'Wrong pin code, Code not sent yet.',
          dialogType: DialogType.error,
          onConfirm: () {
            setState(() {
              _isLoading = false;
            });
          },
          onCancel: null,
        );
      }
    } catch (error) {
      Dialogs.showAwesomeDialog(
        context: context,
        title: 'Wrong Credentials',
        body: 'Wrong pin, please try again',
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

  @override
  void initState() {
    super.initState();
    initFirebaseAuth();
  }

  Future<void> initFirebaseAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final String phone = Get.arguments;

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
        otpVerificationId = verificationId;

        setState(() {
          _isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                appLogoPath,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: _isLoading
                  ? Center(
                      child: SharedCore.buildLoaderIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Verification',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Enter pin code',
                        ),
                        SizedBox(height: 32),
                        Pinput(
                          controller: _pinPutController,
                          onCompleted: _sendOtp,
                          toolbarEnabled: true,
                          enableSuggestions: true,
                          length: 6, // for firebase auth
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
