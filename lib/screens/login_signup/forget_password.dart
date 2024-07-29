import 'package:flutter/material.dart';
import 'package:millyshb/screens/login_signup/otp_verify_screen.dart';
import 'package:millyshb/utills/branded_primary_button.dart';
import 'package:millyshb/utills/branded_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          "Forget Password?",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RichText(
            //   text: const TextSpan(
            //     children: [
            //       TextSpan(
            //         text: "Forget",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 36.0,
            //         ),
            //       ),
            //       TextSpan(
            //         text: "\nPassword?",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 36,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
            BrandedTextField(
              controller: _emailController,
              labelText: "Enter your mail address",
              prefix: const Icon(
                Icons.email,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text.rich(
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
                        " We will send you an OTP to reset your \n   password",
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
            const SizedBox(
              height: 30,
            ),
            BrandedPrimaryButton(
                isEnabled: true,
                name: "Submit",
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const OTPVerifyScreen(
                      mobile: "",
                    );
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
