import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../domain/entity/product_entity.dart';

class OnlineStore {
  String url;
  OnlineStore({required this.url});

  // fetch all products
  Future fetchProductData() async {
    try {
      // String url = 'https://fakestoreapi.com/ProductEntitys';

      http.Response res = await http.get(Uri.parse(url));

      // fetch data successfull then decode it and return
      if (res.statusCode == 200) {
        String data = res.body;

        // decode the json data
        var decodedData = jsonDecode(data);

        // convert json into a list of ProductEntity entity
        List<ProductEntity> productEntityList = (decodedData as List<dynamic>)
            .map<ProductEntity>((json) => ProductEntity.fromJson(json))
            .toList();

        return productEntityList;
      } else {
        log('Error, status code: ${res.statusCode} ');
      }
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }

// fetch all categories
  Future fetchCategoryData() async {
    try {
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        String data = res.body;
        return jsonDecode(data);
      } else {
        print('Error category, status code: ${res.statusCode} ');
        return [];
      }
    } catch (err) {
      print('Error for fetching category: $err');
      return [];
    }
  }

  
}
