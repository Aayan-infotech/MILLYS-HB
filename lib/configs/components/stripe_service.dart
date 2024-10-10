import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:millyshb/configs/components/constants.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();
  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(10, "usd");
      if (paymentIntentClientSecret == null) {
        return;
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            googlePay: PaymentSheetGooglePay(
              merchantCountryCode: "IN", // Use valid country code
              testEnv: true, // Enable test mode
            ), // GooglePayInitParams(merchantName: "Millyshb", countryCode: +91),
            merchantDisplayName: "Millyshb"),
      );
      await _paymentProcess();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _paymentProcess() async {
    try {
      var responce = await Stripe.instance.presentPaymentSheet();
      print(responce);
      //if(responce.);
    } catch (e) {
      print(e);
      print("ERROR");

    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    Dio dio = Dio();

    try {
      // Prepare the data
      Map<String, dynamic> data = {
        "amount": (amount *
            100), // Stripe expects the amount in the smallest currency unit
        "currency": currency
      };

      // Prepare the headers
      Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Content-Type": 'application/x-www-form-urlencoded',
          "Authorization": "Bearer $secretKey"
        },
      );

      // Send the POST request
      var response = await dio
          .post(
            "https://api.stripe.com/v1/payment_intents",
            data: data,
            options: options,
          )
          .timeout(const Duration(seconds: 30));

      // Check for a successful response
      if (response.statusCode == 200) {
        print(response.data);
        return response.data["client_secret"];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
