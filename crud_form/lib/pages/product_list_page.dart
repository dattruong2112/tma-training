// import 'package:flutter/material.dart';
//
// class ProductListPage extends StatelessWidget {
//   final List<Product> products;
//
//   const ProductListPage({super.key, required this.products});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ListTile(
//             title: Text(product.name),
//             subtitle: Text('Description: ${product.description}'),
//             trailing: Text('Quantity: ${product.quantity}'),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class Product {
//   final String name;
//   final String description;
//   final int quantity;
//
//   Product({
//     required this.name,
//     required this.description,
//     required this.quantity,
//   });
// }
