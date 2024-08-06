import 'package:flutter/material.dart';
import 'package:millyshb/configs/routes/routes.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/models/sub_category_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class ImageWidget extends StatefulWidget {
  SubCategory subCategory;
  ImageWidget({required this.subCategory, super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<ProductProvider>(context, listen: false)
              .selectedSubCategoryId = widget.subCategory.id;

          Navigator.of(context).pushNamed(RoutesName.productList);
        },
        child: Column(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.subCategory.pictureUrl)),
            Text(widget.subCategory.title)
          ],
        ),
      ),
    );
  }
}
