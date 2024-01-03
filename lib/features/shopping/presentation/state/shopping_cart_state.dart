import '../../domain/entity/shopping_entity.dart';

class ShoppingCartState {
  static ShoppingCartEntity shoppingCartEntity =
      ShoppingCartEntity(cart: const [], totalAmount: 0);

  ShoppingCartEntity? shoppingCart;

  ShoppingCartState({this.shoppingCart});

  factory ShoppingCartState.initial() {
    return ShoppingCartState(
        shoppingCart: ShoppingCartEntity(cart: const [], totalAmount: 0));
  }

  ShoppingCartState copyWith({ShoppingCartEntity? shoppingCart}) {
    return ShoppingCartState(shoppingCart: shoppingCart ?? this.shoppingCart);
  }
}
