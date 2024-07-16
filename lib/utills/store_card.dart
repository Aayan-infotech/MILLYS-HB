import 'package:flutter/material.dart';
import 'package:millyshb/screens/nav_screen.dart';
import 'package:millyshb/screens/splash/store_splash.dart';
import 'package:millyshb/utills/branded_primary_button.dart';

class StoreCard extends StatefulWidget {
  String name;
  String imagePath;
  bool isFood;
  StoreCard(
      {this.isFood = false,
      required this.imagePath,
      required this.name,
      super.key});

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 218, 218, 248),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 123,
              height: 129,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(image: AssetImage(widget.imagePath))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 140,
                    height: 40,
                    child: BrandedPrimaryButton(
                        isEnabled: true,
                        name: "Shopping",
                        onPressed: () {
                          if (widget.isFood) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return StoreSplashScreen(
                                isFood: widget.isFood,
                              );
                            }));
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return StoreSplashScreen(
                                isFood: widget.isFood,
                              );
                            }));
                          }
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
