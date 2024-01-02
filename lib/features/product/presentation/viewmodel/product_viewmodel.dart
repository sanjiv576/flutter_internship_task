import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/product_use_case.dart';
import '../state/product_state.dart';

// provides the data from usecase to view
final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>((ref) {
  return ProductViewModel(productUseCase: ref.read(productUseCaseProvider));
});

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductUseCase productUseCase;

  ProductViewModel({required this.productUseCase})
      : super(ProductState.initial()) {
    //  initially get all products
    getAllProducts();
  }

  // get all restaurants from usecase
  Future<void> getAllProducts() async {
    // load the screen first
    state = state.copyWith(isLoading: true);

    // get the data
    var data = await productUseCase.getAllProducts();

    // get the failure
    data.fold((failedMessage) {
      // close loading

      state = state.copyWith(isLoading: false, error: failedMessage.toString());
    },
        // get the products
        (gotProducts) {
      // close loading
      state =
          state.copyWith(isLoading: false, error: null, products: gotProducts);
    });
  }
}
