import 'package:flutter/material.dart';
import 'package:millyshb/utills/branded_primary_button.dart';
import 'package:millyshb/utills/branded_text_field.dart';
import 'package:millyshb/utills/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create an account",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: BrandedTextField(
                          controller: _ageController,
                          labelText: "Age",
                          prefix: const Icon(
                            Icons.person,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 29,
                      ),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: 55,
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(255, 226, 226, 245),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete.disableButtonTextColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete
                                        .accentColor), // Change the color as desired
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete
                                        .outLineColor), // Change the color as desired
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              labelText: "Gender",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(103, 103, 103, 1),
                                      fontSize: 12),
                              contentPadding: const EdgeInsets.all(12),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.person,
                                  size: 16,
                                ),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(
                                  'Male',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Pallete.textColor),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(
                                  'Female',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Pallete.textColor),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Other',
                                child: Text(
                                  'Other',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Pallete.textColor),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BrandedTextField(
                    isPassword: true,
                    controller: _passwordController,
                    labelText: "Password",
                    prefix: const Icon(
                      Icons.lock,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BrandedTextField(
                    isPassword: true,
                    controller: _confirmPasswordController,
                    labelText: "ConfirmPassword",
                    prefix: const Icon(
                      Icons.lock,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text:
                                "By clicking the Register button, you agree to the public offer",
                            style: TextStyle()),
                      ])),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BrandedPrimaryButton(
                      isEnabled: true,
                      name: "Create Account",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
