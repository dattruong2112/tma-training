import 'package:flutter/material.dart';
import 'package:shopping_cart_project/widget/sized_box.dart';

class OrderPage extends StatelessWidget {
  final String orderId;
  final String orderDateTime;

  const OrderPage({
    super.key,
    required this.orderId,
    required this.orderDateTime
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page', style: TextStyle(fontFamily: 'Poppins', fontSize: 24),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: $orderId',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            8.0.vertical(),
            Text(
              'Order DateTime: $orderDateTime',
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
