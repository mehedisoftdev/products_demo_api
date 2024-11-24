import 'package:flutter/material.dart';
import 'package:products_view_demo/model/product.dart';
import 'package:products_view_demo/service/api_service.dart';
import 'package:products_view_demo/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // access the viewmodel using provider
    final productViewModel = Provider.of<ProductViewModel>(context);
    // fetch products if not already fetched
    if (productViewModel.isLoading) {
      productViewModel.fetchProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<ProductViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (viewModel.errorMessage.isNotEmpty) {
          // has error
          return Center(
            child: Text(viewModel.errorMessage),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75),
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              final product = viewModel.products[index];
              return ProductCard(product: product);
            },
          );
        }
      }),
    );
  }
}

// designing card for product display
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Card(
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Price: \$${product.price}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ));
  }
}
