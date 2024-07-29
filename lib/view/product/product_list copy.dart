import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/routes/routes_names.dart';

import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/view/product/product_details_screen.dart';
import 'package:millyshb/view_model/select_store_view_model.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final TextEditingController _searchController = TextEditingController();

  final List<int> _quantities = List<int>.filled(6, 0);

  final List<String> imgList = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
  ];

  int get totalProducts {
    return _quantities.reduce((sum, element) => sum + element);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Image(image: AssetImage("assets/images/logo.png")),
        actions: [
          badges.Badge(
            ignorePointer: true,
            badgeContent: Text(
              totalProducts.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            showBadge: totalProducts > 0,
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RoutesName.shoppingBag);
              },
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
      persistentFooterButtons: totalProducts > 0
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Bag:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text("Subtotal($totalProducts items)"),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    width: SizeConfig.blockSizeVertical * 20,
                    child: BrandedPrimaryButton(
                      isEnabled: true,
                      name: "Checkout",
                      onPressed: () {
                        final selectedStore = Provider.of<SelectStoreProvider>(
                                context,
                                listen: false)
                            .selectedStore;
                        if (selectedStore == Store.FOOD) {
                          Navigator.of(context)
                              .pushNamed(RoutesName.selectSlot);
                        } else {
                          Navigator.of(context)
                              .pushNamed(RoutesName.shoppingBag);
                        }
                      },
                    ),
                  ),
                ],
              )
            ]
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BrandedTextField(
              isFilled: false,
              height: 40,
              sufix: const Icon(
                Icons.mic_outlined,
                size: 16,
              ),
              prefix: const Icon(
                Icons.search,
                size: 16,
              ),
              controller: _searchController,
              labelText: "Search any product",
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _quantities.length,
                itemBuilder: (context, item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsScreen(
                            
                          );
                        }));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: SizeConfig.screenHeight * .18,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Container(
                                  height: SizeConfig.screenHeight * .171,
                                  width: SizeConfig.screenWidth * .32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/1.jpg",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.52,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Lorem Ipsum",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(Icons.favorite_outline)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        "500 ml",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                        _quantities[item] == 0
                                        ? SizedBox(
                                            height: 29,
                                            width: 84,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _quantities[item]++;
                                                });
                                              },
                                              style: OutlinedButton.styleFrom(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                backgroundColor: Colors.white,
                                                side: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      202, 202, 202, 1),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Add To Cart",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    if (_quantities[item] > 0) {
                                                      _quantities[item]--;
                                                    }
                                                  });
                                                },
                                              ),
                                              Text(
                                                '${_quantities[item]}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    _quantities[item]++;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       height: 30,
                                      //       width: 84,
                                      //       decoration: BoxDecoration(
                                      //         color: Color.fromRGBO(
                                      //             242, 242, 242, 1),
                                      //         border: Border.all(
                                      //             color: Colors.transparent),
                                      //         borderRadius: BorderRadius.circular(
                                      //             5), // Optional: for rounded corners
                                      //       ),
                                      //       padding: EdgeInsets.all(
                                      //           0), // Optional: for padding inside the border
                                      //       child: const Center(
                                      //         child: Text(
                                      //           "\$225",
                                      //           style: TextStyle(
                                      //               fontSize: 14,
                                      //               fontWeight:
                                      //                   FontWeight.w400),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //         width:
                                      //             10), // Optional: for spacing between the two text fields
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
