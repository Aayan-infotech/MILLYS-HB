import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/view/settings/about_us.dart';
import 'package:millyshb/view/settings/update_password.dart';
import 'package:millyshb/view_model/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkTheme = false;
  @override
  void initState() {
    // TODO: implement initState

    _isDarkTheme = SharedPrefUtil.getValue(isDarkTheme, false) as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          // ListTile(
          //   title: Text('Dark Theme'),
          //   trailing: Switch(
          //     value: _isDarkTheme,
          //     onChanged: (bool value) {
          //       setState(() {
          //         _isDarkTheme = value;
          //       });
          //       if (_isDarkTheme) {
          //         Provider.of<ThemeProvider>(context, listen: false)
          //             .setLightMode();
          //         SharedPrefUtil.setValue(isDarkTheme, false);
          //       } else {
          //         Provider.of<ThemeProvider>(context, listen: false)
          //             .setDarkMode();
          //         SharedPrefUtil.setValue(isDarkTheme, true);
          //       }
          //     },
          //   ),
          // ),
          Divider(),
          ListTile(
            title: Text('Update Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdatePasswordScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              // Add log out functionality here
            },
          ),
        ],
      ),
    );
  }
}
