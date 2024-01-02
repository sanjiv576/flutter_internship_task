import 'package:equatable/equatable.dart';

import '../../../product/domain/entity/product_entity.dart';

class ShoppingCartEntity extends Equatable {
  final String? id;
  final List<ProductEntity> proudctList;
  final double totalAmount;

  const ShoppingCartEntity(
      { this.id, required this.proudctList, required this.totalAmount});

  @override
  List<Object?> get props => [
        id,
        totalAmount,
        proudctList,
      ];

  @override
  String toString() {
    return 'Shopping id: $id, Product list: $proudctList, total amount: $totalAmount';
  }
}
