import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/error_success_dialogue.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/components/stripe_service.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/models/delivery_slot_model.dart';
import 'package:millyshb/view/payment/payment_success_screen.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  var price;
  DeliverySlot deliverySlot;
  PaymentScreen({required this.deliverySlot, required this.price, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                "Checkout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                      Text(
                        "\$ ${(widget.price - int.parse(widget.deliverySlot.price)).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                      Text(
                        "\$ ${widget.deliverySlot.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.4)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$ ${widget.price}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(.5),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Specify the border color
                          width: 1.0, // Specify the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Specify border radius if needed
                        color: Colors.grey
                            .withOpacity(.15) // Specify the background color
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 60,
                          child: Image.asset("assets/images/visa.png"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("******2109"),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckout(
                          sandboxMode: true,
                          clientId: PAYPAL_CLIENT_ID,
                          secretKey: PAYPAL_CLIENT_SECRET,
                          returnURL: "success.aayaninfotech.com",
                          cancelURL: "cancel.aayaninfotech.com",
                          transactions: const [
                            {
                              "amount": {
                                "total": '70',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '70',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              "item_list": {
                                "items": [
                                  {
                                    "name": "Apple",
                                    "quantity": 4,
                                    "price": '5',
                                    "currency": "USD"
                                  },
                                  {
                                    "name": "Pineapple",
                                    "quantity": 5,
                                    "price": '10',
                                    "currency": "USD"
                                  }
                                ],
                                // shipping address is Optional
                                "shipping_address": {
                                  "recipient_name": "Raman Singh",
                                  "line1": "Delhi",
                                  "line2": "",
                                  "city": "Delhi",
                                  "country_code": "IN",
                                  "postal_code": "11001",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "PAYMENT_NOTE",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                          },
                          onError: (error) {
                            print("onError: $error");
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            print('cancelled:');
                          },
                        ),
                      ));
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.withOpacity(.15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 60,
                            child: Image.asset("assets/images/paypal.png"),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text("******2109"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Specify the border color
                          width: 1.0, // Specify the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Specify border radius if needed
                        color: Colors.grey
                            .withOpacity(.15) // Specify the background color
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 60,
                          child: Image.asset("assets/images/maestro.png"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("******2109"),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Specify the border color
                          width: 1.0, // Specify the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Specify border radius if needed
                        color: Colors.grey
                            .withOpacity(.15) // Specify the background color
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 60,
                          child: Image.asset("assets/images/paypal.png"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("******2109"),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: BrandedPrimaryButton(
                        isEnabled: true,
                        name: "Continue",
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          ApiResponseWithData responseWithData =
                              await StripeService.instance.makePayment();
                          if (responseWithData.success) {
                            final cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);
                            final userProvider = Provider.of<UserProvider>(
                                context,
                                listen: false);
                            String addressId =
                                SharedPrefUtil.getValue(selectedAddressId, "")
                                    as String;
                            await cartProvider.createOrder(
                                userId: userProvider.user!.id,
                                deliverySlotId: widget.deliverySlot.id,
                                addressId: addressId,
                                paymentMethod: "stripe",
                                paymentId: responseWithData.data,
                                context: context);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessAndErrorDialougeBox(
                                    subTitle: "Error",
                                    isSuccess: false,
                                    title: responseWithData.message,
                                    action: () {},
                                  );
                                }).then((value) async {});
                          }
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
