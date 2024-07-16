import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius:
              BorderRadius.circular(14.0), // Adjust the radius as needed
          child: Image.asset(
            'assets/images/product.png',
            width: 170.0, // Set your desired width
            height: 124.0, // Set your desired height
            fit: BoxFit.cover, // Set the fit property to cover the entire area
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lorem ispsum",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                width: 170,
                child: Text(
                  "Neque porro quisquam est qui dolorem ipsum quia",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "₹1500",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '₹2499',
                      style: TextStyle(
                          color: Color.fromRGBO(187, 187, 187, 1),
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' 40%Off',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
