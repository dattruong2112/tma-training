// import 'package:crud_form/pages/product_list_page.dart';
// import 'package:crud_form/pages/settings_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final List<Product> products = [];
//   late TextEditingController productNameCtr;
//   late TextEditingController descriptionCtr;
//   late TextEditingController quantityCtr;
//
//   void updateData(Product product) {
//     final index = products.indexWhere((p) => p.name == product.name);
//     if (index != -1) {
//       setState(() {
//         products[index] = product;
//       });
//     }
//   }
//
//   void addData(Product product) {
//     setState(() {
//       products.add(product);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     productNameCtr = TextEditingController();
//     descriptionCtr = TextEditingController();
//     quantityCtr = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     productNameCtr.dispose();
//     descriptionCtr.dispose();
//     quantityCtr.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: const Text(
//           'Product List',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontFamily: 'Poppins-Medium',
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               padding: EdgeInsets.all(50),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Product form',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontFamily: 'Poppins-Medium',
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(CupertinoIcons.gear_alt_fill),
//               title: const Text(
//                 'Settings',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontFamily: 'Poppins-Light',
//                 ),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SettingsPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/background.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Product Form",
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: 'Poppins-Medium'),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: 350,
//                 child: TextField(
//                   controller: productNameCtr,
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter product name',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 width: 350,
//                 child: TextField(
//                   controller: descriptionCtr,
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter description',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 width: 350,
//                 child: TextField(
//                   controller: quantityCtr,
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter quantity',
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     final name = productNameCtr.text;
//                     final description = descriptionCtr.text;
//                     final quantity = int.tryParse(quantityCtr.text) ?? 0;
//                     final product = Product(name: name, description: description, quantity: quantity);
//
//                     final index = products.indexWhere((p) => p.name == product.name);
//                     if (index != -1) {
//                       updateData(product);
//                     } else {
//                       addData(product);
//                     }
//                     formKey.currentState!.reset();
//                   }
//                 },
//                 style: const ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(Colors.blue)),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ProductListPage(products: [],),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'View list',
//                   style: TextStyle(color: Colors.black, fontSize: 24),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Product {
//   String name;
//   String description;
//   int quantity;
//
//   Product({
//     required this.name,
//     required this.description,
//     required this.quantity,
//   });
// }
