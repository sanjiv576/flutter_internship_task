
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../config/router/app_routes.dart';
import '../../../shopping/domain/entity/shopping_entity.dart';
import '../../../shopping/presentation/state/shopping_cart_state.dart';

class CartBottomSheetWidget extends ConsumerStatefulWidget {
  const CartBottomSheetWidget({
    super.key,
    required this.shopping,
  });

  final ShoppingCartEntity shopping;

  @override
  ConsumerState<CartBottomSheetWidget> createState() =>
      _CartBottomSheetWidgetState();
}

class _CartBottomSheetWidgetState extends ConsumerState<CartBottomSheetWidget> {
  void removeFromCart(int index, ShoppingCartEntity shopping, double amount) {
    setState(() {
      shopping.cart.removeAt(index);
      shopping.totalAmount -= amount;
    });

    Navigator.pop(context);
  }

  void placeOrder() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirmation",
      desc: "Are you sure want to shop ?",
      buttons: [
        DialogButton(
          onPressed: () {
            ShoppingCartState.shoppingCartEntity =
                ShoppingCartEntity(cart: const [], totalAmount: 0);
            Navigator.popAndPushNamed(context, AppRoutes.homeRoute);
          },
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Customize the cart display
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your Cart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.shopping.cart.length,
              itemBuilder: (context, index) {
                final productName = widget.shopping.cart[index].productName;
                final price = widget.shopping.cart[index].amount;
                final quantity = widget.shopping.cart[index].quantity;
                return ListTile(
                  title: Text(productName),
                  subtitle: Text('Price: $price | Quantity: $quantity'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeFromCart(index, widget.shopping,
                          widget.shopping.cart[index].amount);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text('Your total amount is Rs ${widget.shopping.totalAmount}'),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  placeOrder();
                },
                child: const Text('Place Order'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
