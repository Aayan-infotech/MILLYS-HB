import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/models/order_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID - ${order.id}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  order.items.first.product.image,
                  height: 80,
                  width: 80,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.items.first.product.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$ ${order.totalAmount}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildOrderStatusTimeline(order),
            Spacer(),
            Row(
              children: [
                Expanded(
                    child: BrandedPrimaryButton(
                        isEnabled: true,
                        isUnfocus: true,
                        name: "Cancel",
                        onPressed: () {
                          //                         DateTime dateTime = DateTime.parse(dateString);

                          // // Format the DateTime object to the desired string format
                          // String formattedDate = DateFormat('EEE MMM d').format(DateTime.parse(dateString));

                          print(order.expectedDeliveryDate);
                        })),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: BrandedPrimaryButton(
                        isEnabled: true,
                        isUnfocus: true,
                        name: "Chat with us",
                        onPressed: () {}))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusTimeline(Order order) {
    // Define the list of statuses and their completion status
    final List<Map<String, dynamic>> steps = [
      {
        'icon': Icons.check_circle,
        'text': 'Order Placed',
        'isCompleted': true,
      },
      {
        'icon': Icons.local_shipping,
        'text': 'Order Dispatched',
        'isCompleted': false,
      },
      {
        'icon': Icons.directions_bike,
        'text': 'Out for Delivery',
        'isCompleted': false,
      },
      {
        'icon': Icons.home,
        'text':
            'Delivered , ${DateFormat('EEE MMM d').format(DateTime.parse(order.expectedDeliveryDate))} \n (${order.deliverySlot.timePeriod})',
        'isCompleted': false,
      },
    ];

    return Column(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          _buildTimelineRow(
            icon: steps[i]['icon'],
            text: steps[i]['text'],
            isCompleted: steps[i]['isCompleted'],
            isLastStep: i == steps.length - 1,
            isFirstStep: i == 0,
          ),
        ],
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTimelineRow({
    required IconData icon,
    required String text,
    required bool isCompleted,
    required bool isLastStep,
    required bool isFirstStep,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Top Line (Always present, color based on completion)
            if (!isFirstStep)
              TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                    begin: Colors.grey,
                    end: isCompleted ? Colors.green : Colors.grey),
                duration: Duration(milliseconds: 500),
                builder: (context, color, child) {
                  return Container(
                    height: 30,
                    width: 2,
                    color: color,
                  );
                },
              ),
            // Circle with icon
            Icon(
              icon,
              color: isCompleted ? Colors.green : Colors.grey,
              size: 24,
            ),
            // Bottom Line (Always present, color based on completion)
            if (!isLastStep)
              TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                    begin: Colors.grey,
                    end: isCompleted ? Colors.green : Colors.grey),
                duration: Duration(milliseconds: 500),
                builder: (context, color, child) {
                  return Container(
                    height: 30,
                    width: 2,
                    color: color,
                  );
                },
              ),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isCompleted ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
