import 'dart:async';
import 'package:crud_form/pages/product_list_page1.dart';
import 'package:crud_form/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> _productLists = [];
  late TextEditingController _productNameCtr;
  late TextEditingController _descriptionCtr;
  late TextEditingController _quantityCtr;
  final StreamController<List<Product>> _streamController =
      StreamController<List<Product>>();

  @override
  void initState() {
    super.initState();
    _productNameCtr = TextEditingController();
    _descriptionCtr = TextEditingController();
    _quantityCtr = TextEditingController();
  }

  @override
  void dispose() {
    _productNameCtr.dispose();
    _descriptionCtr.dispose();
    _quantityCtr.dispose();
    _streamController.close();
    super.dispose();
  }

  void addProduct() {
    final productName = _productNameCtr.text;
    final description = _descriptionCtr.text;
    final quantity = int.tryParse(_quantityCtr.text) ?? 0;

    if (productName.isNotEmpty && description.isNotEmpty && quantity > 0) {
      final newProduct = Product(
        name: productName,
        description: description,
        quantity: quantity,
      );
      setState(() {
        _productLists.add(newProduct);
        _streamController.add(_productLists);
      });

      _productNameCtr.clear();
      _descriptionCtr.clear();
      _quantityCtr.clear();
    }
  }

  void updateProduct(int index, Product updatedProduct) {
    setState(() {
      _productLists[index] = updatedProduct;
      _streamController.add(_productLists);
    });
  }

  void deleteProduct(int index) {
    setState(() {
      _productLists.removeAt(index);
      _streamController.add(_productLists);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Product List',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins-Medium',
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Product form',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.gear_alt_fill),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Poppins-Light',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Product Form",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Poppins-Medium'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _productNameCtr,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Enter product name',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _descriptionCtr,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Enter description',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _quantityCtr,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Enter quantity',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addProduct,
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(
                        productStream: _streamController.stream,
                        onEdit: updateProduct,
                        onDelete: deleteProduct,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View list',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  String name;
  String description;
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
  });
}
