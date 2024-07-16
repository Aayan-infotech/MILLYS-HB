
import 'package:flutter/material.dart';
import 'package:millyshb/screens/splash/welcome_screen.dart';

// import 'package:animated_text/animated_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState();

  final bool _showProgress = true;
  navigate() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false, // Replace false with your predicate condition
    );

    // Future.delayed(Duration(seconds: 3));
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if (SharedPrefUtil.getValue(uidPrefName, '').toString().isNotEmpty) {
    //     Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       Routes.homePage,
    //       (route) => false, // Clear all routes in the stack
    //     );
    //   } else {
    //     Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       Routes.startLoginPage,
    //       (route) => false, // Clear all routes in the stack
    //     );
    //   }
    // });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      navigate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Image(
                      image: AssetImage("assets/images/splash_logo.png"),
                      width: 250.0,
                      height: 250.0,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
