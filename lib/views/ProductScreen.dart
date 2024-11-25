import 'package:flutter/material.dart';
import 'package:products_view_demo/model/product.dart';
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

    // Get orientation
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isLandscape ? 3 : 2, // Dynamic column count
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: isLandscape ? 1.5 : 0.8, // Adjust ratio for landscape
            ),
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              final product = viewModel.products[index];
              return ProductCard(product: product, isLandscape: isLandscape);
            },
          );
        }
      }),
    );
  }
}

// ProductCard widget
class ProductCard extends StatelessWidget {
  final Product product;
  final bool isLandscape;

  const ProductCard({super.key, required this.product, required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    final cardHeight = isLandscape
        ? MediaQuery.of(context).size.height * 0.4
        : MediaQuery.of(context).size.height * 0.3; // Adjust height dynamically
    return SizedBox(
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  height: isLandscape ? cardHeight * 0.4 : cardHeight * 0.3, // Larger for landscape
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Price: \$${product.price}",
                style: const TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}