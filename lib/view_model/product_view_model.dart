import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/product_api.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/category_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/models/sub_category_model.dart';

class ProductProvider with ChangeNotifier {
  // List to hold products
  List<Product> _products = [];
  List<dynamic> _category = [];
  List<dynamic> _subCategory = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Getter for the product list
  List<Product> get products => _products;
  List<dynamic> get category => _category;
  List<dynamic> get subCategory => _subCategory;

  Future getCategoryList(BuildContext context) async {
    _setLoading(true);

    ApiResponseWithData response = await ProductAPIs().getCategories();
    if (response.success) {
      _category = (response.data["data"])
          .map((item) => ProductCategory.fromJson(item))
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
 Future getSubCategoryList(String id,BuildContext context) async {
    _setLoading(true);

    ApiResponseWithData response = await ProductAPIs().getSubCategoriesById(id);
    if (response.success) {
      _subCategory = (response.data["data"])
          .map((item) => SubCategory.fromJson(item))
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

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
