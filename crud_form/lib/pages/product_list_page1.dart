import 'package:crud_form/pages/home_page1.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final Stream<List<Product>> productStream;
  final Function(int index, Product product) onEdit;
  final Function(int index) onDelete;

  const ProductListPage({
    super.key,
    required this.productStream,
    required this.onEdit,
    required this.onDelete,
  });

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
            color: Colors.black,
            fontFamily: 'Poppins-Medium',
          ),
        ),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text('Product Name: ${product.name}'),
                  subtitle: Text(
                      'Description: ${product.description} \n Quantity: ${product.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ProductEdit(
                              product: product,
                              onSave: (updatedProduct) {
                                onEdit(index, updatedProduct);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onDelete(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ProductEdit extends StatefulWidget {
  final Product product;
  final Function(Product) onSave;

  const ProductEdit({
    super.key,
    required this.product,
    required this.onSave,
  });

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _quantityController =
        TextEditingController(text: widget.product.quantity.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final updatedProduct = Product(
              name: _nameController.text,
              description: _descriptionController.text,
              quantity: int.tryParse(_quantityController.text) ?? 0,
            );
            widget.onSave(updatedProduct);
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
