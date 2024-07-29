import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/utills/branded_text_field.dart';
import 'package:millyshb/utills/image_widget.dart';
import 'package:millyshb/utills/product_card.dart';

class ProdeuctDetailsScreen extends StatefulWidget {
  const ProdeuctDetailsScreen({super.key});

  @override
  State<ProdeuctDetailsScreen> createState() => _ProdeuctDetailsScreenState();
}

class _ProdeuctDetailsScreenState extends State<ProdeuctDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  final List<int> _quantities = List<int>.filled(6, 1);

  final List<String> imgList = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Image(image: AssetImage("assets/images/logo.png")),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline))
        ],
      ),
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
                labelText: "Search any product"),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: _quantities.length,
                  itemBuilder: (context, item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 169,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Container(
                                  height: 168,
                                  width: 165,
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
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Lorem Ipsum",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "500 ml",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              setState(() {
                                                if (_quantities[item] > 1) {
                                                  _quantities[item]--;
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            '${_quantities[item]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                _quantities[item]++;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Container focusCard(BuildContext context, String name) {
    return Container(
      color: const Color.fromRGBO(56, 53, 100, 1),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Products",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    side: const BorderSide(width: 2, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Text(
                        "View All ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
