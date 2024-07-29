import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/store_card.dart';

class SelectStoreScreen extends StatefulWidget {
  const SelectStoreScreen({super.key});

  @override
  State<SelectStoreScreen> createState() => _SelectStoreScreenState();
}

class _SelectStoreScreenState extends State<SelectStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "Select Store",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              StoreCard(
                  name: "Cosmetics\nProducts",
                  imagePath: "assets/images/food.png"),
              SizedBox(
                height: 20,
              ),
              StoreCard(
                name: "Dry food /\nFrozen food",
                imagePath: "assets/images/cosmetics.png",
                isFood: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
