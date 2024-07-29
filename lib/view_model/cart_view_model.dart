import 'package:flutter/foundation.dart';
import 'package:millyshb/models/product_model.dart';

class CartProvider with ChangeNotifier {
  // List to hold products
  List<Product> _products = [];

  // Getter for the product list
  List<Product> get products => _products;

  // Method to add a product to the list
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners(); // Notify listeners about changes
  }

  // Method to remove a product from the list
  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners(); // Notify listeners about changes
  }
}
