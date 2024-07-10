// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/utills/branded_primary_button.dart';
import 'package:millyshb/utills/colors.dart';
import 'package:millyshb/utills/miscellaneous.dart';
import 'package:sms_autofill/sms_autofill.dart';

enum OTPVerifyScreenContext { register, passwordReset }

class OTPVerifyScreen extends StatefulWidget {
  final String mobile;
  final bool isWeb;

  const OTPVerifyScreen({Key? key, this.isWeb = false, required this.mobile})
      : super(key: key);
  static const routeName = '/otp-verify';

  @override
  // ignore: library_private_types_in_public_api
  _OTPVerifyScreenState createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool showFadingCircle = false;
  bool isEnable = false;

  late Timer resendTimer;
  bool canResendCode = false;
  int secondsRemaining = 60;
  String _code = "";
  bool isNewUser = false;
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    //  listenOtp();
    startResendTimer();
  }

  // listenOtp() async {
  //   await SmsAutoFill().listenForCode().then((value) {
  //     // setState(() {
  //     //   isEnable = true;
  //     // });
  //   });
  // }

  @override
  void dispose() {
    mobileController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    resendTimer.cancel();
    //SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void startResendTimer() {
    canResendCode = false;
    secondsRemaining = 60;
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsRemaining--;
        if (secondsRemaining == 0) {
          canResendCode = true;
          resendTimer.cancel();
        }
      });
    });
  }

  void _focusNextField(int index) {
    if (index < controllers.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
  }

  void resendCode() {
    setState(() {
      showFadingCircle = true;
      canResendCode = false;
      secondsRemaining = 60;
    });

    startResendTimer();

    setState(() {
      showFadingCircle = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String mobileNumberToDisplay = widget.mobile;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Enter OTP',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: PinFieldAutoFill(
                      autoFocus: true,
                      codeLength: 5,
                      decoration: BoxLooseDecoration(
                          bgColorBuilder: FixedColorBuilder(
                              Color.fromARGB(255, 226, 226, 247)!),
                          radius: const Radius.circular(8),
                          strokeColorBuilder:
                              const FixedColorBuilder(Colors.black)),
                      currentCode: _code,
                      onCodeSubmitted: (code) {
                        setState(() {
                          _code = code;
                          isEnable = true;
                        });
                        // otpVerify();
                      },
                      onCodeChanged: (code) {
                        if (code!.length == 4) {
                          isEnable = true;
                        }
                        setState(() {
                          _code = code;
                        });

                        if (code.length == 5) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Text("Don't recieve the OTP?",
                //           style: Theme.of(context).textTheme.labelMedium),
                //       canResendCode
                //           ? TextButton(
                //               onPressed: resendCode,
                //               child: const Text(
                //                 "Resend OTP",
                //                 style: TextStyle(
                //                   color: Pallete.accentColor,
                //                   fontFamily: 'Product Sans',
                //                   fontSize: 17,
                //                   letterSpacing: 0,
                //                   fontWeight: FontWeight.normal,
                //                   decoration: TextDecoration.none,
                //                   height: 1,
                //                 ),
                //               ),
                //             )
                //           : Text(
                //               "(${secondsRemaining}s)",
                //               style: TextStyle(
                //                 color: Theme.of(context).colorScheme.error,
                //                 fontFamily: 'Product Sans',
                //                 fontSize: 17,
                //                 letterSpacing: 0,
                //                 fontWeight: FontWeight.normal,
                //                 decoration: TextDecoration.none,
                //                 height: 1,
                //               ),
                //             ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "*",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text:
                              " We have send you an OTP to reset your \n   password",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(103, 103, 103,
                                1), // You can change this to the desired color for the rest of the text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BrandedPrimaryButton(
                    name: 'Submit',
                    onPressed: () {},
                    isEnabled: true,
                  ),
                ),
                // AnimatedSwitcher(
                //   duration: const Duration(milliseconds: 500),
                //   child: showFadingCircle
                //       ? const loadingIndicator()
                //       : Padding(
                //           padding: const EdgeInsets.all(16.0),
                //           child: BrandedPrimaryButton(
                //             name: 'Confirm',
                //             onPressed: otpVerify,
                //             isEnabled:
                //                 controllers[controllers.length - 1].text.isNotEmpty,
                //           ),
                //         ),
                // ),
              ],
            ),
          ),
        ),
        if (showFadingCircle) const loadingIndicator()
      ],
    );
  }
}
