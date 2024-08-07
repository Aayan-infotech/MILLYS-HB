import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:exponential_back_off/exponential_back_off.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  final String message;
  final bool success;

  ApiResponse(this.message, this.success);
}

class ApiResponseWithData<T> {
  final T data;
  final bool success;
  final String message;

  ApiResponseWithData(this.data, this.success, {this.message = "none"});
}

class CallHelper {
  static final http.Client httpClient = http.Client();

  final exponentialBackOff = ExponentialBackOff(
    interval:
        const Duration(milliseconds: 2000), //retry after 2, 4, 8, 16 seconds
    maxAttempts: 5,
    maxRandomizationFactor: 0.0,
    maxDelay: const Duration(seconds: 30),
  );

  static String url =
      "http://13.200.240.28:3003/"; //this is initialized in main.dart based on the config choosen

  int timeoutInSeconds = 15;
  String internalServerErrorMessage = "Internal server error.";

  Future<Map<String, String>> getHeaders() async {
    final String role =
        ''; //SharedPrefUtil.getValue(roleSharedPref, "") as String;
    final String id = '';
    //SharedPrefUtil.getValue(loggedInUserMobileSharedPrefName, "") as String;

    var headers = {
      'role': role.toUpperCase(),
      'id': id,
    };

    return headers;
  }

  Future<ApiResponse> get(String urlSuffix,
      {Map<String, String>? queryParams}) async {
    Uri uri;
    if (queryParams != null) {
      uri = Uri.parse('$url$urlSuffix').replace(queryParameters: queryParams);
    } else {
      uri = Uri.parse('$url$urlSuffix');
    }

    final response =
        await httpClient.get(uri, headers: await getHeaders()).timeout(
      Duration(seconds: timeoutInSeconds),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    //handle timeout case
    var message = internalServerErrorMessage;
    if (kDebugMode) {
      print('responce${response.body}');
    }
    if (response.statusCode == 408) {
      return ApiResponse(message, false);
    }

    if (response.body.isNotEmpty) {
      var decodedResponse = jsonDecode(response.body);
      message = decodedResponse['Message'] ?? internalServerErrorMessage;
    }

    if (response.statusCode == 200) {
      return ApiResponse(message, true);
    } else {
      return ApiResponse(message, false);
    }
  }

  Future<ApiResponseWithData<T>> getWithData<T>(String urlSuffix, T defaultData,
      {Map<String, String>? queryParams}) async {
    Uri uri;
    if (queryParams != null) {
      uri = Uri.parse('$url$urlSuffix').replace(queryParameters: queryParams);
    } else {
      uri = Uri.parse('$url$urlSuffix');
    }
    final response =
        await httpClient.get(uri, headers: await getHeaders()).timeout(
      Duration(seconds: timeoutInSeconds),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    var decodedResponse =
        (response.statusCode != 404) ? jsonDecode(response.body) : "";

    if (response.statusCode == 200 && decodedResponse != null) {
      return ApiResponseWithData(decodedResponse as T, true);
    } else if (response.statusCode == 404) {
      return ApiResponseWithData(
        defaultData,
        false,
        message: "Not Found",
      );
    } else {
      return ApiResponseWithData(defaultData, false,
          message: decodedResponse['message'] ?? internalServerErrorMessage);
    }
  }

  Future<ApiResponse> delete(String urlSuffix, Map<String, String> body) async {
    /// The result will be of type [Either<Exception, Response>]
    final result = await exponentialBackOff.start<http.Response>(
      // Make a request
      () async {
        return http
            .delete(Uri.parse('$url$urlSuffix'),
                body: body, headers: await getHeaders())
            .timeout(Duration(seconds: timeoutInSeconds));
      },
      // Retry on SocketException or TimeoutException and other then that the process
      // will stop and return with the error
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    var returnValue = ApiResponse(internalServerErrorMessage, false);

    result.fold(
      (error) {
        //do nothing
      },
      (response) {
        var message = internalServerErrorMessage;
        if (kDebugMode) {
          print('Server Response${response.body}');
        }
        //handle timeout case
        if (response.statusCode == 408) {
          return ApiResponse(message, false);
        }

        if (response.body.isNotEmpty) {
          var decodedResponse = jsonDecode(response.body);

          try {
            message = decodedResponse['message'] ?? internalServerErrorMessage;
          } catch (ex) {
            //do nothing
          }
        }

        if (response.statusCode == 200) {
          returnValue = ApiResponse(message, true);
        } else {
          returnValue = ApiResponse(message, false);
        }
      },
    );

    return returnValue;
  }

  Future<ApiResponse> put(String urlSuffix, Map<String, String> body) async {
    /// The result will be of type [Either<Exception, Response>]
    final result = await exponentialBackOff.start<http.Response>(
      // Make a request
      () async {
        return http
            .put(Uri.parse('$url$urlSuffix'),
                body: body, headers: await getHeaders())
            .timeout(Duration(seconds: timeoutInSeconds));
      },
      // Retry on SocketException or TimeoutException and other then that the process
      // will stop and return with the error
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    var returnValue = ApiResponse(internalServerErrorMessage, false);

    result.fold(
      (error) {
        //do nothing
      },
      (response) {
        var message = internalServerErrorMessage;
        if (kDebugMode) {
          print('Server Response${response.body}');
        }
        //handle timeout case
        if (response.statusCode == 408) {
          return ApiResponse(message, false);
        }

        if (response.body.isNotEmpty) {
          var decodedResponse = jsonDecode(response.body);

          try {
            message = decodedResponse['message'] ?? internalServerErrorMessage;
          } catch (ex) {
            //do nothing
          }
        }

        if (response.statusCode == 200) {
          returnValue = ApiResponse(message, true);
        } else {
          returnValue = ApiResponse(message, false);
        }
      },
    );

    return returnValue;
  }

  Future<ApiResponse> post(String urlSuffix, Map<String, String> body) async {
    /// The result will be of type [Either<Exception, Response>]
    final result = await exponentialBackOff.start<http.Response>(
      // Make a request
      () async {
        return http
            .post(Uri.parse('$url$urlSuffix'),
                body: body, headers: await getHeaders())
            .timeout(const Duration(seconds: 30));
      },
      // Retry on SocketException or TimeoutException and other then that the process
      // will stop and return with the error
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    var returnValue = ApiResponse(internalServerErrorMessage, false);

    result.fold(
      (error) {
        //do nothing
      },
      (response) {
        var message = internalServerErrorMessage;
        print(response.body);

        //handle timeout case
        if (response.statusCode == 408) {
          return ApiResponse(message, false);
        }

        if (response.body.isNotEmpty) {
          var decodedResponse = jsonDecode(response.body);

          try {
            message = decodedResponse['Message'] ?? internalServerErrorMessage;
          } catch (ex) {
            //do nothing
          }
        }

        if (response.statusCode == 200) {
          returnValue = ApiResponse(message, true);
        } else {
          returnValue = ApiResponse(message, false);
        }
      },
    );

    return returnValue;
  }

  Future<ApiResponseWithData<T>> postWithData<T>(
      String urlSuffix, Map<String, String> body, T defaultData) async {
    print(url);
    final response = await httpClient
        .post(Uri.parse('$url$urlSuffix'),
            body: body, headers: await getHeaders())
        .timeout(
      Duration(seconds: timeoutInSeconds),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    print(response);
    var decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponseWithData(decodedResponse as T, true);
    } else {
      print(decodedResponse['message']);
      return ApiResponseWithData(defaultData, false,
          message: decodedResponse['message'] ?? internalServerErrorMessage);
    }
  }

  Future<ApiResponse> registerBusiness(
      String mobile,
      String email,
      String name,
      String password,
      String ownername,
      String industry,
      String companySymbol,
      String city) async {
    Map<String, String> data = {
      'name': name,
      'password': password,
      'ownername': ownername,
      'industry': industry,
      'mobile': mobile,
      'email': email,
      "city": city
    };
    return post('bizzhub/$companySymbol', data);
  }
}
