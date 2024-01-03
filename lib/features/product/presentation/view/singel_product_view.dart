import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:online_store/core/common/widget/snackbar_messages.dart';
import 'package:online_store/features/shopping/domain/entity/shopping_entity.dart';
import 'package:online_store/features/shopping/presentation/state/shopping_cart_state.dart';
import 'package:online_store/features/shopping/presentation/viewmodel/shopping_cart_viewmodel.dart';

import '../widget/button_widget.dart';

final counterProvider = StateProvider<int>((ref) => 0);

class SingleProductView extends ConsumerStatefulWidget {
  const SingleProductView({super.key});

  @override
  ConsumerState<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends ConsumerState<SingleProductView> {
  var _product;
  var ic = FontAwesomeIcons.minus;

  @override
  void didChangeDependencies() {
    _product = ModalRoute.of(context)!.settings.arguments as dynamic;

    super.didChangeDependencies();

    //  reset counter when navigating to the next screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetCounter();
    });
  }

  final _verticalGap = const SizedBox(height: 12);
  final _horizontalGap = const SizedBox(width: 20);

  void _decrement() {
    if (ref.watch(counterProvider) > 0) {
      ref.watch(counterProvider.notifier).state -= 1;
    } else {
      showSnackbarMsg(
        context: context,
        targetTitle: 'Warning',
        targetMessage: 'Cannot be less than 0.',
        type: ContentType.warning,
      );
    }
  }

  void _increment() {
    if (ref.watch(counterProvider) < 8) {
      ref.watch(counterProvider.notifier).state += 1;
    } else {
      showSnackbarMsg(
        context: context,
        targetTitle: 'Warning',
        targetMessage: 'Cannot be greater than 8.',
        type: ContentType.warning,
      );
    }
  }

  void _addToCart() {
    final quantityValue = ref.watch(counterProvider);
    final double totalPrice = _product.price * quantityValue;
    Cart addedCart = Cart(
      productId: _product.id.toString(),
      productName: _product.title.toString(),
      quantity: quantityValue,
      amount: totalPrice,
    );
    log('Cart: $addedCart');

    double previousAmount = ShoppingCartState.shoppingCartEntity.totalAmount;

    ShoppingCartState.shoppingCartEntity = ShoppingCartEntity(
        id: 'd',
        cart: [...ShoppingCartState.shoppingCartEntity.cart, addedCart],
        totalAmount: totalPrice + previousAmount);

    log('Shopping Cart: ${ShoppingCartState.shoppingCartEntity}');

    // send data to the viewmodel
    ref.watch(shoppingCartViewModelProvider).addToCart(
        cartList: [...ShoppingCartState.shoppingCartEntity.cart, addedCart],
        totalAmount: totalPrice + previousAmount);

    // reset counter
    _resetCounter();

    Fluttertoast.showToast(
        msg: 'Added to cart.', backgroundColor: Colors.green);
  }

  void _resetCounter() {
    ref.watch(counterProvider.notifier).state = 0;
  }

  @override
  void dispose() {
    _resetCounter();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int counterValue = ref.watch(counterProvider);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(_product.image),
              ),
              _verticalGap,
              Text(
                'Name:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                _product.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              _verticalGap,
              Text(
                'Price: ${NumberFormat.simpleCurrency().format(_product.price)}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              _verticalGap,
              Text(
                'Description:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(_product.description),
              _verticalGap,
              Text(
                'Rating: ${_product.rating}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              _verticalGap,
              _verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    ic: FontAwesomeIcons.minus,
                    onPress: _decrement,
                  ),
                  _horizontalGap,
                  Text(
                    counterValue.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  _horizontalGap,
                  ButtonWidget(
                    ic: FontAwesomeIcons.plus,
                    onPress: _increment,
                  ),
                ],
              ),
              _verticalGap,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    // _submit(ref);
                    if (ref.watch(counterProvider) == 0) {
                      showSnackbarMsg(
                        context: context,
                        targetTitle: 'Error',
                        targetMessage: 'Please, select the quantity',
                        type: ContentType.failure,
                      );
                      return;
                    }
                    _addToCart();
                  },
                  child: Text(
                    'Add to Cart',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
