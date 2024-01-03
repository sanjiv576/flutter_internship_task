import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/shopping_entity.dart';
import '../state/shopping_cart_state.dart';

final shoppingCartViewModelProvider =
    Provider((ref) => ShoppingCartViewModel());

class ShoppingCartViewModel extends StateNotifier<ShoppingCartState> {

  // final ShoppingCartUseCase shoppingCartUseCase;
  ShoppingCartViewModel() : super(ShoppingCartState.initial());

// add a product to the cart
  void addToCart({required List<Cart> cartList, required double totalAmount}) {
    // add product
    // state.shoppingCart!.cart.add(cartList);

    state = state.copyWith(
        shoppingCart:
            ShoppingCartEntity(cart: cartList, totalAmount: totalAmount));
  }
}
