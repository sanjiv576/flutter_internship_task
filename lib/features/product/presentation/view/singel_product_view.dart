import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:online_store/core/common/widget/snackbar_messages.dart';
import 'package:online_store/features/shopping/domain/entity/shopping_entity.dart';
import 'package:online_store/features/shopping/presentation/state/shopping_cart_state.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/product_entity.dart';
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

    print('Prod name: ${_product.title}');
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

  void _submit(ref) {
    if (ref.watch(counterProvider) == 0) {
      showSnackbarMsg(
        context: context,
        targetTitle: 'Error',
        targetMessage: 'Please, select the quantity',
        type: ContentType.failure,
      );
    }
  }

  ShoppingCartEntity? shoppingCartEntity;

  @override
  void initState() {
    super.initState();
    // _resetCounter();

    shoppingCartEntity = ShoppingCartState.shoppingCart;
  }

  void _addToCart(ProductEntity productToAdd) {
    if (shoppingCartEntity!.proudctList.isEmpty) {
      // If the product list is empty, create a new ShoppingCartEntity with the provided product
      shoppingCartEntity = ShoppingCartEntity(
        proudctList: [productToAdd],
        totalAmount: productToAdd.price,
      );
    } else {
      // If the product list is not empty, add the product to the list and update the total amount
      List<ProductEntity> updatedProductList =
          List.from(shoppingCartEntity!.proudctList)..add(productToAdd);

      // Calculate the new total amount
      double updatedTotalAmount =
          shoppingCartEntity!.totalAmount + productToAdd.price;

      // Update the shoppingCartEntity with the new product list and total amount
      shoppingCartEntity = ShoppingCartEntity(
        id: shoppingCartEntity!.id,
        proudctList: updatedProductList,
        totalAmount: updatedTotalAmount,
      );
    }
    print('shopping: $shoppingCartEntity');
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
                    _addToCart(_product);
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
