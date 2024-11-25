import 'dart:convert';
import 'package:products_view_demo/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = "https://fakestoreapi.com/";
  static const String productListEndPoint = "${apiUrl}products";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(productListEndPoint));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<Product> insertProduct(Product product) async {
    final response = await http.post(Uri.parse(productListEndPoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(product.toJson())); // convert product model to json

    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to insert product");
    }
  }
}
