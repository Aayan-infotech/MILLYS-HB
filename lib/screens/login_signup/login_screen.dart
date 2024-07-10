import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/screens/login_signup/forget_password.dart';
import 'package:millyshb/screens/login_signup/sign_up_screen.dart';
import 'package:millyshb/screens/select_store_screen.dart';
import 'package:millyshb/utills/branded_primary_button.dart';
import 'package:millyshb/utills/branded_text_field.dart';
import 'package:millyshb/utills/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Welcome",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: " MILLYS",
                style: TextStyle(
                  color: Pallete.redColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: " HB!",
                style: TextStyle(
                  color: Pallete.accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RichText(
              //   text: const TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "Welcome",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 36.0,
              //             fontWeight: FontWeight.w700),
              //       ),
              //       TextSpan(
              //         text: "\nMILLYS",
              //         style: TextStyle(
              //           color: Pallete.redColor,
              //           fontSize: 36,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //       TextSpan(
              //         text: " HB!",
              //         style: TextStyle(
              //           color: Pallete.accentColor,
              //           fontSize: 36,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              BrandedTextField(
                controller: _emailController,
                labelText: "Username or email",
                prefix: const Icon(
                  Icons.person,
                  size: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BrandedTextField(
                controller: _userNameController,
                labelText: "Password",
                isPassword: true,
                prefix: const Icon(
                  Icons.lock,
                  size: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ForgetPasswordScreen();
                      }));
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(53, 53, 100, 1)),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              BrandedPrimaryButton(
                  isEnabled: true,
                  name: "Login",
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SelectStoreScreen();
                    }));
                  }),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Create an account ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(
                                87, 87, 87, 1)), // Set the color for this text
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 53, 100,
                                1) // Set the color for the clickable text
                            ),
                        recognizer: _tapGestureRecognizer
                          ..onTap = () {
                            // Handle the click event here
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            }));
                            // You can navigate to another screen or perform any action here
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
