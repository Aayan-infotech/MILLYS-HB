import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/cart_api.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/product_model.dart';

class CartProvider with ChangeNotifier {
  Cart _cart = Cart(
      id: '',
      user: '',
      products: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 0);
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  // Getter for the product list
  dynamic get userCart => _cart;

  addTOCart(Product product, String userId, BuildContext context) async {
    ApiResponseWithData response =
        await CartAPIs().addProductToCart(product.id, userId);
    if (response.success) {
      // (userCart as Cart).products.add(product);
      await getCart(userId, context);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Product Added"),
      //   backgroundColor: Colors.green,
      // ));
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(response.message),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
    notifyListeners();
  }

  getCart(String userId, BuildContext context) async {
    _setLoading(true);
    ApiResponseWithData response = await CartAPIs().getCart(userId);
    if (response.success) {
      _cart = Cart.fromJson(response.data["data"]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data),
          backgroundColor: Colors.red,
        ),
      );
    }
    _setLoading(false);
  }

  removeFromCart(String userId, Product product, BuildContext context) async {
    ApiResponse response = await CartAPIs().removeProduct(
      product.id,
      userId,
    );
    if (response.success) {
      int index =
          _cart.products.indexWhere((product) => product.id == product.id);
      _cart.products.removeAt(index);

      //(userCart as Cart).products.remove(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  increaseProductQuantity(
      String userId, Product product, BuildContext context) async {
    ApiResponse response = await CartAPIs().increaseProduct(
      product.id,
      userId,
    );
    if (response.success) {
      await getCart(userId, context);

      // int index =
      //     _cart.products.indexWhere((product) => product.id == product.id);
      // _cart.products.removeAt(index);

      //(userCart as Cart).products.remove(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  decreaseProductQuantity(
      String userId, Product product, BuildContext context) async {
    ApiResponse response = await CartAPIs().decreaseProduct(
      product.id,
      userId,
    );
    if (response.success) {
      await getCart(userId, context);

      // int index =
      //     _cart.products.indexWhere((product) => product.id == product.id);
      // _cart.products.removeAt(index);

      //(userCart as Cart).products.remove(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    // notifyListeners();
  }
}
