import 'package:flutter/material.dart';
import 'package:products_view_demo/model/product.dart';
import 'package:products_view_demo/service/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Product> get products => _products;

  // fetch products data
  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners(); // Notify listeners to rebuild UI during loading

      _products = await ApiService.fetchProducts();
      _isLoading = false;
      notifyListeners(); // Notify listeners to update UI after loading completes
    }catch(e) {
      _errorMessage = 'Error $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}