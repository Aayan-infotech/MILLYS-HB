import 'package:millyshb/configs/network/api_base.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/user_model.dart';

class LoginAPIs extends ApiBase {
  LoginAPIs() : super();

  Future<ApiResponseWithData<Map<String, dynamic>>> login(
      String email, String password) async {
    Map<String, String> data = {'password': password, 'emailOrUsername': email};

    return await CallHelper().postWithData('api/auth/login', data, {});
  }

  // userName,
  //     email,
  //     password,
  //     mobileNumber,
  //     age,
  //     gender
  Future<ApiResponseWithData<Map<String, dynamic>>> signUp(User user) async {
    Map<String, String> data = {
      'userName': user.userName,
      'email': user.email,
      'mobileNumber': user.mobileNumber,
      'age': user.age.toString(),
      'password': user.password,
      'gender':user.gender
    };

    return await CallHelper().postWithData('api/user/register', data, {});
  }

  Future<ApiResponse> sendOTP(String mobile) async {
    return await CallHelper().get('otp/$mobile/generate-otp');
  }

  Future<ApiResponse> verifyOTP(String mobile, String otp) async {
    Map<String, String> data = {
      'otp': otp,
    };
    return await CallHelper().post('otp/$mobile/verify-otp', data);
  }

  Future<ApiResponse> checkUserExistence(String mobile) async {
    return await CallHelper().get('business/$mobile/existence/$mobile');
  }

  // Future<ApiResponseWithData<Map<String, dynamic>>>
  //     getLoggedInUserDetails() async {
  //   return await CallHelper()
  //       .getWithData('business/$companySymbol/details', {});
  // }

  Future<ApiResponse> passwordReset(String mobile, String password) async {
    Map<String, String> data = {
      'password': password,
      'mobile': mobile,
    };
    return await CallHelper().post('business/$mobile/password', data);
  }
}
