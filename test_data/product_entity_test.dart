import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:online_store/features/product/domain/entity/product_entity.dart';

Future<List<ProductEntity>> getProductTest() async {
  // read data ie product  from the file
  final response =
      await rootBundle.loadString('test_data/product_test_data.json');

  // decode the JSON
  final jsonList = await json.decode(response);

  // convert each decoded JSON of product  object and add in the list
  final List<ProductEntity> productList = jsonList
      .map<ProductEntity>((json) => ProductEntity.fromJson(json))
      .toList();

  return Future.value(productList);
}
