import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/size_config.dart';
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
                      Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$ ${widget.price}",
                        style: TextStyle(fontWeight: FontWeight.w600),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          print(userProvider.user!.id);
                          print(widget.deliverySlot.id);
                          await cartProvider.createOrder(userProvider.user!.id,
                              widget.deliverySlot.id, context);

                          setState(() {
                            isLoading = false;
                          });
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
