import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/user_model.dart';

class CartAPIs extends ApiBase {
  CartAPIs() : super();

  Future<ApiResponseWithData<Map<String, dynamic>>> addProductToCart(
      String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
      'quantity': '1'
    };

    return await CallHelper().postWithData('api/cart/add', data, {});
  }

  Future<ApiResponse> removeProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
    };

    return await CallHelper().delete(
      'api/cart/delete',
      data,
    );
  }

  Future<ApiResponse> increaseProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
    };

    return await CallHelper().put(
      'api/cart/increase',
      data,
    );
  }

  Future<ApiResponse> decreaseProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
    };

    return await CallHelper().put(
      'api/cart/decrease',
      data,
    );
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getCart(
      String userId) async {
    return await CallHelper().getWithData('api/cart/get/${userId}', {});
  }
}
