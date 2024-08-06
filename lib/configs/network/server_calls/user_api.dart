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


  //
 Future<ApiResponse> sendOTO( String email) async {
    Map<String, String> data = {
      'email': email,
    };
    return await CallHelper().post('api/auth/send-email', data);
  }
Future<ApiResponseWithData<Map<String, dynamic>>> verifyOTP( String otp) async {
    Map<String, String> data = {
      'otp': otp,
    };
    return await CallHelper().postWithData('api/auth/verifyOTP', data,{});
  }

  Future<ApiResponse> checkUserExistence(String mobile) async {
    return await CallHelper().get('business/$mobile/existence/$mobile');
  }


  Future<ApiResponse> passwordReset(String token, String password) async {
    Map<String, String> data = {
      'newPassword': password,
      'token': token,
    };
    
    return await CallHelper().post('api/auth/reset-password', data);
  }
}
