import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/common/widget/snackbar_messages.dart';
import '../../../../shopping/domain/entity/shopping_entity.dart';
import '../../../../shopping/presentation/state/shopping_cart_state.dart';
import '../../../data/data_source/remote/networking.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../../widget/cart_bottom_sheet_widget.dart';
import '../../widget/categories_widget.dart';
import '../../widget/product_card_widget.dart';

class HomepageView extends ConsumerStatefulWidget {
  const HomepageView({super.key});

  @override
  ConsumerState<HomepageView> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomepageView> {
  // var _products;

  late double width;
  late double height;
  late Future<List<dynamic>>? _categoriesFuture;

  // late Future<List<dynamic>>? _products;

  @override
  void initState() {
    super.initState();

    // _products = getProductData();
    _categoriesFuture = getCategoryData();
  }

  Future<List<dynamic>> getCategoryData() async {
    try {
      OnlineStore onlineStore = OnlineStore(url: ApiEndpoints.getAllCategories);
      List<dynamic> categories = await onlineStore.fetchCategoryData();
      log('Category length: ${categories.length}');
      return categories;
    } catch (err) {
      return []; // Handle the error appropriately
    }
  }

  final _verticalGap = const SizedBox(height: 30);
  final _horizontalGap = const SizedBox(width: 20);

  @override
  Widget build(BuildContext context) {
    // getCategoryData();

    // get sizes of the device, then, send to device size class
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    log('Width: $width');
    log('Height: $height');

    final productState = ref.watch(productViewModelProvider);
    if (productState.products != [] && productState.products != null) {
      log('Total len of products from clean arch = HOmepage: ${productState.products!.length}');
    }

    void showCart() {
      ShoppingCartEntity shopping = ShoppingCartState.shoppingCartEntity;

      if (shopping.cart.isEmpty) {
        showSnackbarMsg(
            context: context,
            targetTitle: 'Info',
            targetMessage: 'Please, add to cart some products.',
            type: ContentType.help);
        return;
      }
      showModalBottomSheet(
        context: context,
        builder: (context) => CartBottomSheetWidget(shopping: shopping),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Title(color: Colors.pink, child: const Text('View Cart')),
          // const Text('View Cart'),
          IconButton(
              onPressed: () {
                showCart();
              },
              icon: const Icon(Icons.shopping_cart_checkout))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              _verticalGap,
              if (productState.isLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                ),
              } else if (productState.error != null) ...{
                Center(
                  child: Text(productState.error.toString()),
                )
              } else ...{
                CategoriesWidget(
                  categoriesFuture: _categoriesFuture,
                  horizontalGap: _horizontalGap,
                  verticalGap: const SizedBox(
                    height: 10,
                  ),
                ),
              },
              _verticalGap,
              const Text(
                'All Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              _verticalGap,

              if (productState.isLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                ),
              } else if (productState.error != null) ...{
                Center(
                  child: Text(productState.error.toString()),
                )
              } else ...{
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // no. of columns in the grid
                      crossAxisSpacing: 16.0, // spacing between columns
                      mainAxisSpacing: 8.0, // spacing between rows
                    ),
                    itemCount: productState.products!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var product = productState.products![index];

                      return ProductCard(product: product);
                    },
                  ),
                ),
              },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
