// this class is a child of ProudctRepository to implment all abstract methods
// from fetching the data remotely

// returns the data to the --> domain ---> repo

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_store/core/failure/failure.dart';
import 'package:online_store/features/product/data/data_source/remote/product_remote_data_source.dart';

import 'package:online_store/features/product/domain/entity/product_entity.dart';

import '../../domain/repository/product_repository.dart';

final productRemoteRepositoryImplProvider = Provider((ref) {
  // return the data by fetching from remote data source ---> domain ---> repo
  return ProductRemoteRepositoryImpl(
    productRemoteDataSource: ref.read(productRemoteDataSourceProvider),
  );
});

class ProductRemoteRepositoryImpl implements IProductRepository {
  // make object of remote data source to fetch data by calling its methods
  ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getAllCategories() {
   return productRemoteDataSource.getAllCategories();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productRemoteDataSource.getAllProducts();
  }

  @override
  Future<Either<Failure, ProductEntity>> getSingleProduct() {
    // TODO: implement getSingleProduct
    throw UnimplementedError();
  }
}
