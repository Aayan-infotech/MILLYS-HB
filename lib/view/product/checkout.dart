import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/models/delivery_slot_model.dart';
import 'package:millyshb/view/address/address_screen.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/view/product/order_summery_screen.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  String selectedDate = "Today";

  String selectedDeliveryType = "Free Delivery";

  DeliverySlot selectedTimeSlot = DeliverySlot.defaultDeliverySlot();

  bool isLoading = false;

  loadSlot() async {
    setState(() {
      isLoading = true;
    });
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    await cartProvider.getSlot(
        DateFormat('yyyy-MM-dd').format(DateTime.now()), context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadSlot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));

    Address selectedAddress =
        Provider.of<AddressProvider>(context, listen: false).address.isNotEmpty
            ? Provider.of<AddressProvider>(context, listen: false).address[0]
            : Address(
                houseNumber: "12",
                userId: "",
                name: "Home",
                mobileNumber: "",
                street: "",
                city: "",
                state: "state",
                postalCode: "",
                country: "",
                addressType: AddressType.HOME);

    String formatDate(DateTime date) {
      return DateFormat('d MMM').format(date);
    }

    return isLoading
        ? loadingIndicator()
        : Stack(
            children: [
              Scaffold(
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
                persistentFooterButtons: [
                  BrandedPrimaryButton(
                    isEnabled:selectedTimeSlot.id.isNotEmpty,
                    name: "Proceed",
                    onPressed: () {
                      
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return OrderSummery(
                          deliverySlot: selectedTimeSlot,
                        );
                      }));
                    },
                  ),
                ],
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        if (selectedAddress.mobileNumber.isNotEmpty)
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                              ),
                              Text(
                                "Delivery Address",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        if (selectedAddress.mobileNumber.isNotEmpty)
                          Container(
                              child: Card(
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
                                        const Text(
                                          "Address",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: const Icon(
                                            Icons.edit_square,
                                            size: 16,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    selectedAddress.houseNumber +
                                        ' ' +
                                        selectedAddress.street +
                                        ' ' +
                                        selectedAddress.city +
                                        ' ' +
                                        selectedAddress.state +
                                        ' ' +
                                        selectedAddress.country +
                                        ' ' +
                                        selectedAddress.postalCode,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Contact : ${selectedAddress.mobileNumber}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          )),
                        Text(
                          "Select a Date",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Card(
                                elevation: selectedDate == "Today" ? 4 : 2,
                                color: selectedDate == "Today"
                                    ? Colors.blue[50]
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                      selectedDate = "Today";
                                      _dateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now());
                                    });
                                    await cartProvider.getSlot(
                                        _dateController.text, context);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Today",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(formatDate(today)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Card(
                                elevation: selectedDate == "Tomorrow" ? 4 : 2,
                                color: selectedDate == "Tomorrow"
                                    ? Colors.blue[50]
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   selectedDate = "Tomorrow";
                                    //   _dateController.text = DateFormat('yyyy-MM-dd')
                                    //       .format(DateTime.now().add(Duration(days: 1)));
                                    // });
                                  },
                                  child: Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tomorrow",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(formatDate(tomorrow)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Card(
                                elevation: selectedDate == "Later" ? 4 : 2,
                                color: selectedDate == "Later"
                                    ? Colors.blue[50]
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        selectedDate = "Later";
                                        _dateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Later",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(selectedDate == "Later" &&
                                                _dateController.text.isNotEmpty
                                            ? formatDate(DateTime.parse(
                                                _dateController.text))
                                            : "Select Date"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Time Slot",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // height: SizeConfig.screenHeight * 0.26,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Free Delivery",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  selectedDeliveryType ==
                                                          "Free Delivery"
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedDeliveryType =
                                                "Free Delivery";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Morning Delivery \n- Rs ${cartProvider.lstMorningSlot[0].price}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: selectedDeliveryType ==
                                                      "Morning Delivery - Rs 19"
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedDeliveryType =
                                                "Morning Delivery - Rs 19";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Express Delivery \n-  Rs ${cartProvider.lstExpressDeliverySlot[0].price}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: selectedDeliveryType ==
                                                      "Express Delivery - Rs 49"
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedDeliveryType =
                                                "Express Delivery - Rs 49";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Fixed Time Delivery \n ${cartProvider.lstfixedTimeDelivery[0].price}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  selectedDeliveryType ==
                                                          "FixedTimeDelivery"
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedDeliveryType =
                                                "FixedTimeDelivery";
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // height: SizeConfig.screenHeight * 0.26,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "SELECT AN OPTION",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(.4)),
                                      ),
                                    ),
                                    if (selectedDeliveryType ==
                                        "Morning Delivery - Rs 19")
                                      Column(
                                        children: cartProvider.lstMorningSlot
                                            .map((slot) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2, right: 5),
                                                  child: Row(
                                                    children: [
                                                      Radio<DeliverySlot>(
                                                        value: slot,
                                                        groupValue:
                                                            selectedTimeSlot,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedTimeSlot =
                                                                value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          slot.timePeriod,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    if (selectedDeliveryType ==
                                        "Express Delivery - Rs 49")
                                      Column(
                                        children:
                                            cartProvider.lstExpressDeliverySlot
                                                .map((slot) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2, right: 5),
                                                      child: Row(
                                                        children: [
                                                          Radio<DeliverySlot>(
                                                            value: slot,
                                                            groupValue:
                                                                selectedTimeSlot,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedTimeSlot =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              slot.timePeriod,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                      ),
                                    if (selectedDeliveryType ==
                                        "FixedTimeDelivery")
                                      Column(
                                        children:
                                            cartProvider.lstfixedTimeDelivery
                                                .map((slot) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2, right: 5),
                                                      child: Row(
                                                        children: [
                                                          Radio<DeliverySlot>(
                                                            value: slot,
                                                            groupValue:
                                                                selectedTimeSlot,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedTimeSlot =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              slot.timePeriod,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                      ),
                                    if (selectedDeliveryType == "Free Delivery")
                                      Column(
                                        children: cartProvider.lstFreeDelivery
                                            .map((slot) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2, right: 5),
                                                  child: Row(
                                                    children: [
                                                      Radio<DeliverySlot>(
                                                        value: slot,
                                                        groupValue:
                                                            selectedTimeSlot,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedTimeSlot =
                                                                value!;
                                                          });
                                                          selectedTimeSlot
                                                              .price = "0";
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          slot.timePeriod,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   height: 65,
                        //   width: MediaQuery.of(context).size.width,
                        //   decoration: BoxDecoration(
                        //     color: Color.fromRGBO(242, 242, 242, 1),
                        //     border: Border.all(color: Colors.transparent),
                        //     borderRadius: BorderRadius.circular(
                        //         10), // Optional: for rounded corners
                        //   ),
                        //   padding: EdgeInsets.all(
                        //       0), // Optional: for padding inside the border
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 30),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         SizedBox(
                        //           height: 10,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               "Delivery slot:",
                        //               style: TextStyle(
                        //                   fontSize: 14, fontWeight: FontWeight.w600),
                        //             ),
                        //             Icon(
                        //               Icons.keyboard_control_key,
                        //               size: 25,
                        //             )
                        //           ],
                        //         ),
                        //         Text(
                        //           "30 May, 11:20am",
                        //           style: TextStyle(fontWeight: FontWeight.w400),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // if (isLoading)
              //   loadingIndicator(
              //     isTransParent: true,
              //   )
            ],
          );
  }
}
