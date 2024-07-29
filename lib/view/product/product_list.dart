import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:millyshb/configs/components/constants.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/login_signup/login_screen.dart';
import 'package:millyshb/view/product/product_details_screen.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/select_store_view_model.dart';
import 'package:provider/provider.dart';

// Import your Cart class

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final TextEditingController _searchController = TextEditingController();

  final List<Product> _products = [
    Product(id: '1', name: 'Product 1', price: 29.99),
    Product(id: '2', name: 'Product 2', price: 49.99),
    Product(id: '3', name: 'Product 3', price: 19.99),
  ];
  void _showLoginBottomSheet(BuildContext context) {
    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: .8, // Set to 1.0 to cover the full screen initially
          minChildSize: .1, // Minimum height when partially dragged
          maxChildSize: 1, // Maximum height when fully dragged
          expand: true,
          builder: (context, scrollController) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: LoginScreen(
                  isbottomSheet: true,
                ));
          },
        );
      },
    ).whenComplete(() {
      // Call setState to update the UI after the bottom sheet is closed
      setState(() {});
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    bool isLogin = SharedPrefUtil.getValue(isLogedIn, false) as bool;

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
              cart.products.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            showBadge: cart.products.length > 0,
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              onPressed: () {
                if (isLogin) {
                  Navigator.of(context).pushNamed(RoutesName.shoppingBag);
                } else {
                  _showLoginBottomSheet(context);
                }
              },
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
      persistentFooterButtons: cart.products.length > 0
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BrandedPrimaryButton(
                      isEnabled: true,
                      name: "Go to cart",
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
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];

                  bool inCart = false;
                  for (var cartProduct in cart.products) {
                    if (cartProduct.id == product.id) {
                      inCart = true;
                      break;
                    }
                  }
                  final quantity =
                      cart.products.where((p) => p.id == product.id).length;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsScreen();
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
                                        child: Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
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
                                      if (inCart) ...[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                if (quantity >= 1) {
                                                  cart.removeProduct(product);
                                                } else {
                                                  cart.removeProduct(product);
                                                }
                                              },
                                            ),
                                            Text(
                                              '$quantity',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                cart.addProduct(product);
                                              },
                                            ),
                                          ],
                                        ),
                                      ] else ...[
                                        SizedBox(
                                          height: 29,
                                          width: 84,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if (isLogin) {
                                                cart.addProduct(product);
                                              } else {
                                                _showLoginBottomSheet(context);
                                              }
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
                                        ),
                                      ],
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
