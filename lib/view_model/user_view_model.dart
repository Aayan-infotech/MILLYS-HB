import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/user_api.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view/select_store_screen.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  // Getter to retrieve the current user
  User? get user => _user;

  // Getter to check loading state
  bool get isLoading => _isLoading;

  login(String userNameOrEmail, String password, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response =
        await LoginAPIs().login(userNameOrEmail, password);
    if (response.success) {
      _user = User.fromJson(response.data['data']);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const SelectStoreScreen();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Internal server error'),
          backgroundColor: Colors.red,
        ),
      );
    }
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  userSignup(User user, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response = await LoginAPIs().signUp(user);
    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User Registered'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.red,
        ),
      );
    }
    _setLoading(false);
  }
}
