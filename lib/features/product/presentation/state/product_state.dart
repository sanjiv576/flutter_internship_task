import 'package:online_store/features/product/domain/entity/product_entity.dart';

// this class controls the states of the product
class ProductState {
  final bool isLoading;

  final String? error;
  final List<ProductEntity>? products;

  ProductState({required this.isLoading, this.error, this.products});

// initial state
  factory ProductState.initial() {
    return ProductState(isLoading: false, error: null, products: []);
  }

  // for updating the state

  ProductState copyWith(
      {bool? isLoading, String? error, List<ProductEntity>? products}) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
    );
  }
}
