// this class fetches the data from ---> domain --> repo
// returns the data to the viewmodel

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

final productUseCaseProvider = Provider((ref) {
  return ProductUseCase(
      iProductRepository: ref.read(iProductRepositoryProvider));
});

class ProductUseCase {
  IProductRepository iProductRepository;
  ProductUseCase({required this.iProductRepository});

  // get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return iProductRepository.getAllProducts();
  }
  // get all categories
  Future<Either<Failure, List<String>>> getAllCategories() {
    return iProductRepository.getAllCategories();
  }
}
