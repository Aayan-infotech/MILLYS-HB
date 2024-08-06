import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/models/cart_product_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/product/checkout.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsScreen extends StatefulWidget {
  Product product;

  ProductDetailsScreen({required this.product, super.key});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentIndex = 0;
  int _quantity = 1; // Initial quantity
  bool isInCart = false;
  bool isStackLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      widget.product.image,
    ];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    bool inCart = false;
    for (var cartProduct in (cart.userCart as Cart).products) {
      if (cartProduct.product.id == widget.product.id) {
        inCart = true;
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Product Name"),
            centerTitle: true,
            actions: [
              badges.Badge(
                ignorePointer: true,
                badgeContent: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return Center(
                      child: Text(
                        (cart.userCart as Cart).products.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                showBadge: (cart.userCart as Cart).products.length > 0,
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
          persistentFooterButtons: [
            Row(
              children: [
                Expanded(
                  child: BrandedPrimaryButton(
                    isUnfocus: true,
                    isEnabled: true,
                    name: inCart ? "Go to cart" : "Add to cart",
                    onPressed: () async {
                      setState(() {
                        isStackLoading = true;
                      });
                      if (inCart) {
                        Navigator.of(context).pushNamed(RoutesName.shoppingBag);
                      } else {
                        await cart.addTOCart(
                            widget.product, userProvider.user!.id, context);
                      }
                      setState(() {
                        isStackLoading = false;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: BrandedPrimaryButton(
                    isEnabled: true,
                    name: "Buy Now",
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CheckOutScreen();
                      }));
                    },
                  ),
                ),
              ],
            )
          ],
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: SizeConfig.screenHeight * .42,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: imgList
                            .map((item) => GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          item,
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: SizeConfig.screenHeight * 0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.map((urlOfItem) {
                          int index = imgList.indexOf(urlOfItem);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.product.name,
                    style: TextStyle(
                        color: Pallete.accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(widget.product.description),
                  // SizedBox(height: 20),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Lorem Ipsum",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Lorem Ipsum")
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Lorem Ipsum",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Lorem Ipsum")
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Lorem Ipsum",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //     Text("Lorem Ipsum")
                  //   ],
                  // ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 30,
                        width: 84,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 242, 242, 1),
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(0),
                        child: Center(
                          child: Text(
                            "\$${widget.product.price}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (isInCart)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.black),
                              onPressed: () {
                                // cart.removeProduct(product);

                                setState(() {
                                  if (_quantity > 1) {
                                    _quantity--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$_quantity',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.black),
                              onPressed: () {
                                // cart.addProduct(product);

                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        if (isStackLoading)
          loadingIndicator(
            isTransParent: true,
          )
      ],
    );
  }
}
