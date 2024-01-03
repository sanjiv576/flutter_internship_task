import 'package:equatable/equatable.dart';

class Cart {
  final String productId;
  final String productName;
  final int quantity;
  final double amount;

  Cart({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.amount,
  });

  @override
  String toString() {
    return 'Product id: $productId, Product name: $productName, Quantity: $quantity, Amount: $amount';
  }
}

class ShoppingCartEntity extends Equatable {
  final String? id;
  // final List<ProductEntity> proudctList;
  final List<Cart> cart;
  double totalAmount;
  // final int quantity;

  ShoppingCartEntity({
    this.id,
    // required this.proudctList,
    required this.cart,
    required this.totalAmount,
    // required this.quantity,
  });

  @override
  List<Object?> get props => [id, totalAmount, cart, cart];

  @override
  String toString() {
    return 'Shopping id: $id, Cart list: $cart, total amount: $totalAmount, ';
  }
}
