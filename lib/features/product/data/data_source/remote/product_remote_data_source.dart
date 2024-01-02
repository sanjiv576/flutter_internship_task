// returns the data to the ---> data --> repo --> product_remote_repo
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/config/constants/api_endpoints.dart';

import '../../../../../core/failure/failure.dart';
import '../../../domain/entity/product_entity.dart';
import 'package:http/http.dart' as http;

final productRemoteDataSourceProvider =
    Provider((ref) => ProductRemoteDataSource());

// this  class directly interacts with the server/API
class ProductRemoteDataSource {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      http.Response res =
          await http.get(Uri.parse(ApiEndpoints.getAllProducts));

      // fetch data successfully then decode it and return in a list
      if (res.statusCode == 200) {
        String data = res.body;

        // decode the json data
        var decodedData = jsonDecode(data);

        // convert json into a list of ProductEntity
        List<ProductEntity> productEntityList = (decodedData as List<dynamic>)
            .map<ProductEntity>((json) => ProductEntity.fromJson(json))
            .toList();

        return Right(productEntityList);
      } else {
        return Left(Failure(error: 'Failed to fetch Products data from API'));
      }
    } catch (err) {
      return Left(Failure(error: err.toString()));
    }
  }

  // get all categories
  Future<Either<Failure, List<String>>> getAllCategories() async {
    try {
      http.Response res =
          await http.get(Uri.parse(ApiEndpoints.getAllCategories));

      // fetch data successfully then decode it and return in a list
      if (res.statusCode == 200) {
        String data = res.body;

        // decode the json data
        var decodedData = jsonDecode(data);
        return Right(decodedData);
      } else {
        return Left(Failure(error: 'Failed to fetch Products data from API'));
      }
    } catch (err) {
      return Left(Failure(error: err.toString()));
    }
  }
}
