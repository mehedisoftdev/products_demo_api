import 'package:flutter/material.dart';
import 'package:products_view_demo/model/product.dart';
import 'package:provider/provider.dart';

import '../viewmodel/product_viewmodel.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: const AddProductForm(),
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final productViewModel = Provider.of<ProductViewModel>(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField(
              controller: _productTitleController,
              labelText: 'Enter Product Title',
              hintText: 'Product title'),
          const SizedBox(
            height: 16,
          ),
          buildTextField(
              controller: _productPriceController,
              labelText: 'Enter Product Price',
              hintText: 'Product price',
              inputType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(
            height: 16,
          ),
          buildTextField(
              controller: _productDescriptionController,
              labelText: 'Enter Product Description',
              hintText: 'Product short desc'),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  doSaveOperation(productViewModel);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: const Text("Save")),
          ),
          const SizedBox(height: 16),
          if (productViewModel.errorMessage.isNotEmpty)
            Text(
              productViewModel.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  void doSaveOperation(ProductViewModel productViewModel) {
    String title = _productTitleController.text.toString();
    double price =
        double.tryParse(_productPriceController.text.toString()) ?? 0.0;
    String description = _productDescriptionController.text.toString();

    // validation
    if (title.isEmpty || price <= 0 || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly!')),
      );
      return;
    }

    // Create a Product object
    Product newProduct = Product(
      title: title,
      price: price,
      description: description,
      category: 'electronic',
      image: 'https://i.pravatar.cc', // Example static image
    );
    // Add product via ViewModel
    productViewModel.addProduct(newProduct);

    _productTitleController.clear();
    _productPriceController.clear();
    _productDescriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added successfully!')),
    );

    // Navigator.pop(context); // Go back to the previous screen

  }

  TextField buildTextField(
      {TextEditingController? controller,
      String? labelText,
      String hintText = '',
      TextInputType? inputType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          hintText: hintText),
      keyboardType: inputType ?? TextInputType.text,
    );
  }
}
