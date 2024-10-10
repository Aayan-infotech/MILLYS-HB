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
    };

    return await CallHelper().delete(
      'api/cart/delete/$productId',
      data,
    );
  }

  Future<ApiResponse> increaseProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
      'operation': "increase"
    };

    return await CallHelper().put(
      'api/cart/change',
      data,
    );
  }

  Future<ApiResponse> decreaseProduct(String productId, String userId) async {
    Map<String, String> data = {
      'userId': userId,
      'productId': productId,
      'operation': "decrease"
    };

    return await CallHelper().put(
      'api/cart/change',
      data,
    );
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getCart(
      String userId) async {
    Map<String, String> data = {
      'userId': userId,
    };
    return await CallHelper().getWithData('api/cart/get/${userId}', data);
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getSlot(
      String deliveryType) async {
    // deliveryType
    Map<String, String> data = {"deliveryType": deliveryType};

    return await CallHelper().getWithData('api/deliveryslot/get', data);
  }
}
