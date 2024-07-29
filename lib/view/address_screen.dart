import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _houseNumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Address",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      persistentFooterButtons: [],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BrandedTextField(controller: _nameController, labelText: "Name"),
            SizedBox(
              height: 15,
            ),
            BrandedTextField(
                controller: _houseNumberController, labelText: "House Number"),
            SizedBox(
              height: 15,
            ),
            BrandedTextField(controller: _cityController, labelText: "City"),
            SizedBox(
              height: 15,
            ),
            BrandedTextField(controller: _stateController, labelText: "State"),
            SizedBox(
              height: 15,
            ),
            BrandedTextField(
                controller: _contactNumberController,
                labelText: "Contact Number"),
            SizedBox(
              height: 20,
            ),
            Text(
                "Lorem Ipsum is simply dummy text of the printing austry's standard dummy text ever since the 1500s, when an"),
            SizedBox(
              height: 25,
            ),
            BrandedPrimaryButton(
                isEnabled: true,
                name: "Save",
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
