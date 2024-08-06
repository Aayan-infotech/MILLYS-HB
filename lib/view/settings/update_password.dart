import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/user_api.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  String token;

  UpdatePasswordScreen({required  this.token,super.key});
  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            BrandedTextField(
                controller: _currentPasswordController,
                labelText: "Current Password"),
            SizedBox(
              height: 20,
            ),
            BrandedTextField(
                controller: _newPasswordController, labelText: "New Password"),
            SizedBox(
              height: 20,
            ),
            BrandedTextField(
                controller: _currentPasswordController,
                labelText: "Confirm New Password"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
               
                ApiResponse apiResponse = await LoginAPIs()
                    .passwordReset(widget.token, _newPasswordController.text);
                if (apiResponse.success) {
                  print("susccess");
                }
              },
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
