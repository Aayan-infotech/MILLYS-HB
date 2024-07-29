import 'package:flutter/material.dart';
import 'package:millyshb/screens/food_nav_screen.dart';
import 'package:millyshb/screens/nav_screen.dart';

class StoreSplashScreen extends StatefulWidget {
  final bool isFood;

  const StoreSplashScreen({super.key, required this.isFood});

  @override
  _StoreSplashScreenState createState() => _StoreSplashScreenState();
}

class _StoreSplashScreenState extends State<StoreSplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _navigateToHome();
  }

  _startAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    if (widget.isFood) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FoodNavScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2),
          child: widget.isFood
              ? Image.asset(
                  'assets/images/food_splash.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                )
              : Image.asset(
                  'assets/images/cosmetics_splash.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}
