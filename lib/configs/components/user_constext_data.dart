import 'package:flutter/material.dart';
import 'package:millyshb/models/user_model.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UserContextData {
  static User? _user;

  static User? get user => _user;

  static setCurrentUserAndFetchUserData(BuildContext context) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    _user = user;
    List<Future> lstFutures = <Future>[];

    lstFutures.add(productProvider.getCategoryList(context));
    // lstFutures
    //     .add(addressProvider.getAddressList(userProvider.user!.id, context));

    await Future.wait(lstFutures);
  }
}
