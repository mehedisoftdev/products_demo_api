import 'package:flutter/material.dart';
import 'package:products_view_demo/views/ProductScreen.dart';


class ProductsDemoApp extends StatelessWidget {
  const ProductsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductScreen()
    );
  }
}
