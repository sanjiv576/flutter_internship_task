import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/product_remote_repository_impl.dart';
import '../entity/product_entity.dart';

// this class makes decision the fetching the data from either remotely or locally

final iProductRepositoryProvider =
    Provider((ref) => ref.watch(productRemoteRepositoryImplProvider));

abstract class IProductRepository {
  // get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  // get all cateegories
  Future<Either<Failure, List<String>>> getAllCategories();

  // get a product
  Future<Either<Failure, ProductEntity>> getSingleProduct();
}
