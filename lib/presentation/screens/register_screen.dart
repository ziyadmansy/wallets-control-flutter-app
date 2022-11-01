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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String phone = '';

  bool _isLoading = false;

  void _registerUser() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid ?? false) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState?.save();
      FocusScope.of(context).unfocus();

      try {
        final authData = Get.find<AuthController>();

        FirebaseAuth auth = FirebaseAuth.instance;

        await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            print('verificationCompleted');
            print(credential.asMap());

            // Register new user
            await authData.registerUser(name: name, walletPhone: phone);

            await auth.signInWithCredential(credential);

            Get.offNamed(AppRoutes.homeRoute);
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

            // Register User to get access token
            await authData.registerUser(name: name, walletPhone: phone);

            setState(() {
              _isLoading = false;
            });

            Get.offNamed(AppRoutes.homeRoute);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } on FirebaseAuthException catch (error) {
        Get.snackbar(
          'Wrong OTP',
          error.code,
          backgroundColor: redColor,
        );
        setState(() {
          _isLoading = false;
        });
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
      } finally {
        setState(() {
          _isLoading = false;
        });
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
                  hint: 'Name',
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (text) {},
                  onValidate: (text) {
                    if (text == null || text.isEmpty) {
                      return 'user name is missing';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (text) {
                    name = text!;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                SharedCore.buildClickableTextForm(
                  hint: 'ex: 01022223333',
                  label: 'Wallet Number',
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
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
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SharedCore.buildRoundedElevatedButton(
                    btnChild: _isLoading
                        ? SharedCore.buildLoaderIndicator()
                        : const Text('Register'),
                    onPress: _isLoading ? null : _registerUser,
                  ),
                ),
                const SizedBox(
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
