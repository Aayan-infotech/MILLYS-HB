import 'package:flutter/material.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/network/server_calls/cart_api.dart';
import 'package:millyshb/configs/network/server_calls/product_api.dart';
import 'package:millyshb/models/category_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/models/sub_category_model.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _products = [];
  List<dynamic> _favProducts = [];
  List<dynamic> _category = [];
  List<dynamic> _subCategory = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _selectedCategoryId = '';
  String _selectedSubCategoryId = '';
  String get selectedCategoryId => _selectedCategoryId;
  String get selectedSubCategoryId => _selectedSubCategoryId;
  List<dynamic> get products => _products;
  List<dynamic> get favProduct => _favProducts;
  List<dynamic> get category => _category;
  List<dynamic> get subCategory => _subCategory;

  set selectedCategoryId(String selectedCategoryId) {
    _selectedCategoryId = selectedCategoryId;
    notifyListeners();
  }

  set selectedSubCategoryId(String selectedSubCategoryId) {
    _selectedSubCategoryId = selectedSubCategoryId;
    notifyListeners();
  }

  Future<void> getCategoryList(BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response = await ProductAPIs().getCategories();
      if (response.success) {
        _category = (response.data["data"] as List)
            .map((item) => ProductCategory.fromJson(item))
            .toList();
      } else {
        // _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      // _showErrorSnackbar(context, 'Failed to load categories');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getSubCategoryList(String id, BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response =
          await ProductAPIs().getSubCategoriesById(id);
      if (response.success) {
        _subCategory = (response.data["subcategories"] as List)
            .map((item) => SubCategory.fromJson(item))
            .toList();
      } else {
        _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load subcategories');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getFavProduct(String id, BuildContext context) async {
    try {
      ApiResponseWithData response = await ProductAPIs().getFavoriteProduct(id);
      if (response.success) {
        _favProducts = (response.data['data']["products"] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load subcategories');
    } finally {}
    notifyListeners();
  }

  Future<void> getProductList(String id, BuildContext context) async {
    _setLoading(true);

    try {
      ApiResponseWithData response = await ProductAPIs().getProductById(id);
      if (response.success) {
        _products = response.data["status"] == 404
            ? []
            : (response.data["data"] as List)
                .map((item) => Product.fromJson(item))
                .toList();
      } else {
        _showErrorSnackbar(context, 'Internal server error');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to load products');
    } finally {
      notifyListeners();
    }
  }

  addFavProduct(Product product, String userId, BuildContext context) async {
    ApiResponseWithData response =
        await ProductAPIs().addFavorite(product.id, userId);
    if (response.success) {
      await getFavProduct(userId, context);
    } else {}
    notifyListeners();
  }

  removeFavProduct(Product product, String userId, BuildContext context) async {
    ApiResponse response =
        await ProductAPIs().removeFavorite(product.id, userId);
    if (response.success) {
      await getFavProduct(userId, context);
    } else {}
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    //notifyListeners();
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Colors.red,
    //   ),
    // );
  }
}
