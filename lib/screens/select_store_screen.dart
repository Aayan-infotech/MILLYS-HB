import 'package:flutter/material.dart';
import 'package:millyshb/utills/store_card.dart';

class SelectStoreScreen extends StatefulWidget {
  const SelectStoreScreen({super.key});

  @override
  State<SelectStoreScreen> createState() => _SelectStoreScreenState();
}

class _SelectStoreScreenState extends State<SelectStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Select Store",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            StoreCard(
              name: "Dry food /\nFrozen food",
              imagePath: "assets/images/cosmetics.png",
            ),
            StoreCard(
                name: "Cosmetics\nProducts",
                imagePath: "assets/images/food.png"),
          ],
        ),
      ),
    );
  }
}
