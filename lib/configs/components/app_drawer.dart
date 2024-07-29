import 'package:flutter/material.dart';
import 'package:millyshb/view/about_us.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    width: 200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        // DrawerHeader(
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //   ),
        //   child: Text(
        //     'Drawer Header',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 24,
        //     ),
        //   ),
        // ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            // Handle the Home tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: Text('Product'),
          onTap: () {
            // Handle the Settings tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: Text('About Us'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AboutUs();
            })); // Close the drawer
          },
        ),
        ListTile(
          title: Text('Support'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: Text('Blogs'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: Text('Log out'),
          onTap: () {
            // Handle the Contact Us tap
            Navigator.pop(context); // Close the drawer
          },
        ),
      ],
    ),
  );
}
