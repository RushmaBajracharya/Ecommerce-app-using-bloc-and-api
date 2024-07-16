import 'dart:convert';

import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<ProductDataModel>> fetchPosts() async {
    var client = http.Client();
    List<ProductDataModel> products = [];
    try {
      var response =
          await client.get(Uri.parse('https://fakestoreapi.com/products'));

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        ProductDataModel product =
            ProductDataModel.fromJson(result[i] as Map<String, dynamic>);
        products.add(product);
      }
      return products;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
