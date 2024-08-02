import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/address_api.dart';
import 'package:millyshb/models/address_model.dart';

class AddressProvider with ChangeNotifier {
  // List to hold products
  List<dynamic> _address = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Getter for the product list
  List<dynamic> get address => _address;

  getAddressList(String userId, BuildContext context) async {
    ApiResponseWithData response = await AddressAPIs().getAddressList(userId);
    if (response.success) {
      _address = (response.data["data"])
          .map((addressJson) => Address.fromJson(addressJson))
          .toList();
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

  saveAddress(Address address, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response = await AddressAPIs().saveAddress(address);
    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Address Added Successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      await getAddressList(address.userId, context);
      Navigator.of(context).pop();
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
   editAddress(Address address, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response = await AddressAPIs().editAddress(address);
    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Address Added Successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      await getAddressList(address.userId, context);
      Navigator.of(context).pop();
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

  deleteAddress(Address address, BuildContext context) async {
    ApiResponse response =
        await AddressAPIs().deleteAddress(address.addressId!);
    if (response.success) {
      _address.remove(address);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.green,
        ),
      );
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
}
