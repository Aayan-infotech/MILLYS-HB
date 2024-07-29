// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:millyshb/utills/colors.dart';

class ZeusTheme {
  static final ThemeData _instance = ThemeData.light().copyWith(
    primaryColor: const Color.fromARGB(255, 130, 110, 194), //#826EC2
    //SecondaryColor: Color.fromRGBO(236, 233, 231, 1),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color.fromARGB(255, 230, 248, 130)),
    //buttonColor: Color(0xFF1DBFAF),
  );

  static ThemeData get() {
    return _instance;
  }
}

class loadingIndicator extends StatelessWidget {
  const loadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitFadingCircle(
          color: Pallete.accentColor,
          size: 30.0,
        ),
      ),
    );
  }
}

class TextRegularStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 14.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class bodyText {
  static const TextStyle _instance = TextStyle(
    fontSize: 16.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextSubRegularStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 12.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final String text;
  final double fontSize;

  const Button({
    super.key,
    required this.onTap,
    required this.width,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: SizedBox(
        width: width,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}

class TextPagetitleStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 21.0, //previous value 20
    // color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextButtonStyle {
  static const TextStyle _instance = TextStyle(
    fontSize: 18.0, //previous value 20
    color: Colors.black,
    fontFamily: 'Product Sans',
  );

  static TextStyle get() {
    return _instance;
  }
}

class TextTileStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold);

  static TextStyle get() {
    return _instance;
  }
}

class TextBottomStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 10.0,
      color: Colors.white,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold);

  static TextStyle get() {
    return _instance;
  }
}

class TextTileNumberStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 40.0,
      color: Colors.white,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold);

  static TextStyle get() {
    return _instance;
  }
}

class ErrorTextStyle {
  static const TextStyle _instance = TextStyle(
      fontSize: 15.0,
      color: Colors.red,
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.w400);

  static TextStyle get() {
    return _instance;
  }
}

createUniqueid() {
  return DateTime.now().microsecondsSinceEpoch.remainder(2);
}
