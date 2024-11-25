import 'package:flutter/material.dart';
import 'package:products_view_demo/products_demo_app.dart';
import 'package:products_view_demo/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: const ProductsDemoApp(),
    ),
  );
}

