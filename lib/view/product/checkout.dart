import 'package:flutter/material.dart';
import 'package:millyshb/view/address_screen.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/view/product/order_summery_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                ),
                Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              height: 250,
              child: ListView.builder(
                itemCount: 3, // Assuming you have 3 items, adjust as needed
                itemBuilder: (context, index) {
                  if (index == 2) {
                    // This is the last item, render the OutlinedButton
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            color: Colors.white,
                            elevation: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                // Define your onPressed function here
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.transparent,
                                ),
                                minimumSize: Size(
                                    double.infinity, 50), // Full-width button
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AddressScreen();
                                        }));
                                      },
                                      icon: const Icon(Icons.add,
                                          size: 16, color: Colors.black),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // For other items, render your Card as before
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.edit_square,
                                      size: 16,
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "216 St Paul's Rd, London N1 2LL",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Contact : +919783847848",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Text(
              "Select Slot",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 242, 1),
                border: Border.all(color: Colors.transparent),
                borderRadius:
                    BorderRadius.circular(10), // Optional: for rounded corners
              ),
              padding:
                  EdgeInsets.all(0), // Optional: for padding inside the border
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery slot:",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.keyboard_control_key,
                          size: 25,
                        )
                      ],
                    ),
                    Text(
                      "30 May, 11:20am",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            BrandedPrimaryButton(
                isEnabled: true,
                name: "Proceed",
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OrderSummery();
                  }));
                })
          ],
        ),
      ),
    );
  }
}
