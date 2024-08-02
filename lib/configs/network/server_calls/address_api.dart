import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/user_model.dart';

class AddressAPIs extends ApiBase {
  AddressAPIs() : super();

  Future<ApiResponseWithData<Map<String, dynamic>>> saveAddress(
      Address address) async {
    Map<String, String> data = {
      'userId': address.userId,
      'houseNumber': address.houseNumber,
      'state': address.state,
      'city': address.city,
      'pinCode': address.postalCode,
      'contactNumber': address.mobileNumber,
      'area': address.street
    };

    return await CallHelper().postWithData('api/address/add', data, {});
  }
  // "userId": "669e2f350a92abdbb4e2003c", // Example User ID
  //   "houseNumber": "123A",
  //   "state": "California",
  //   "city": "Los Angeles",
  //   "pinCode": "90001",
  //   "contactNumber": "+1-234-567-8901",
  //   "area":"new delhi

  Future<ApiResponseWithData<Map<String, dynamic>>> editAddress(
      Address address) async {
    Map<String, String> data = {
      'userId': address.userId,
      'houseNumber': address.houseNumber,
      'state': address.state,
      'city': address.city,
      'pinCode': address.postalCode,
      'contactNumber': address.mobileNumber,
      'area': address.street
    };
    return await CallHelper()
        .postWithData('api/address/update/${address.addressId}', data, {});
  }

  Future<ApiResponseWithData<Map<String, dynamic>>> getAddressList(
      String userId) async {
    return await CallHelper().getWithData('api/address/get/${userId}', {});
  }

  Future<ApiResponse> deleteAddress(String userId) async {
    return await CallHelper().delete('api/address/delete/${userId}', {});
  }
}
