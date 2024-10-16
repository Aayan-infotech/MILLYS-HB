import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/pdf_api.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/user_constext_data.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/google_auth.dart';
import 'package:millyshb/configs/network/server_calls/user_api.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view/feed_screen/home_screen.dart';
import 'package:millyshb/view/select_store_screen.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  final GoogleAuth _googleAuth = GoogleAuth();

  // Getter to retrieve the current user
  UserModel? get user => _user;

  // Getter to check loading state

  // Setter to update the current user
  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  login(String userNameOrEmail, String password, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response =
        await LoginAPIs().login(userNameOrEmail, password);
    if (response.success) {
      SharedPrefUtil.setValue(isLogedIn, true);

      String token = response.data['token'];

      SharedPrefUtil.setValue(userToken, token);

      _user = UserModel.fromJson(response.data['data']);
      await UserContextData.setCurrentUserAndFetchUserData(context);

      PDFApi.saveFileToLocalDirectory(
          jsonEncode(_user!.toJson()), userDetailsLocalFilePath);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const SelectStoreScreen();
      }));
    } else {
      _showSnackBar(context, 'Internal server error', Colors.red);
    }
    _setLoading(false);
  }

  userSignup(UserModel user, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response = await LoginAPIs().signUp(user);
    if (response.success) {
      _showSnackBar(context, 'User Registered', Colors.green);
      Navigator.of(context).pop();
    } else {
      _showSnackBar(context, "Invalid email/username or password", Colors.red);
    }
    _setLoading(false);
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    User? user = await _googleAuth.signInWithGoogle();

    if (user != null) {
    
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      print('Failed to sign in with Google.');
      // Handle Google sign-in failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in failed.')),
      );
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    // notifyListeners();
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    });
  }
}
