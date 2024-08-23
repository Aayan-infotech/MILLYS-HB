import 'package:flutter/material.dart';
import 'package:millyshb/models/order_model.dart';
import 'package:millyshb/models/product_model.dart';
import 'package:millyshb/view/product/order_details.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MyOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Back button functionality
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              productProvider.getOrderList(userProvider.user!.id, context);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your order here',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: productProvider.orders.length,
        itemBuilder: (context, index) {
          Order order = productProvider.orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(
                order.items.first.product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(order.status),
              subtitle: Text(order.items.first.product.name),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return OrderDetailsScreen(
                    order: order,
                  );
                }));
              },
            ),
          );
        },
      ),
    );
  }
}

class OrderItem {
  final String imageUrl;
  final String title;
  final String status;

  OrderItem({
    required this.imageUrl,
    required this.title,
    required this.status,
  });
}
