import 'dart:convert';
import 'package:products_view_demo/model/product.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String apiUrl = "https://fakestoreapi.com/products";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if(response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    }else {
      throw Exception("Failed to load products");
    }
  }
}