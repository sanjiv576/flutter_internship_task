import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data_source/remote/networking.dart';
import '../../viewmodel/product_viewmodel.dart';
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
  String categoryUrl = 'https://fakestoreapi.com/products/categories';
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
      OnlineStore onlineStore = OnlineStore(url: categoryUrl);
      List<dynamic> categories = await onlineStore.fetchCategoryData();
      print('Category length: ${categories.length}');
      return categories;
    } catch (err) {
      print('Error ca: $err');
      return []; // Handle the error appropriately
    }
  }

  // Future<List<dynamic>> getProductData() async {
  //   OnlineStore onlineStore =
  //       OnlineStore(url: 'https://fakestoreapi.com/products');

  //   var products = await onlineStore.fetchProductData();

  //   if (products != null) {
  //     // for (int i = 0; i < products.length; i++) {
  //     //   print('id: ${products[i].id}');
  //     //   print('Product ${i + 1}: ${products[i]}');
  //     //   print('---------------');
  //     // }

  //     // _products = products;
  //     return products;
  //   }
  //   return [];
  // }

  final _verticalGap = const SizedBox(height: 30);
  final _horizontalGap = const SizedBox(width: 20);

  @override
  Widget build(BuildContext context) {
    // getCategoryData();

    // get sizes of the device, then, send to device size class
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print('Width: $width');
    print('Height: $height');

    final productState = ref.watch(productViewModelProvider);
    if (productState.products != [] && productState.products != null) {
      log('Total len of products from clean arch = HOmepage: ${productState.products!.length}');
    }

    return Scaffold(
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
              _verticalGap,
              // Flexible(
              // flex: 4,
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

                // Expanded(
                //   child: ListView.separated(
                //     itemBuilder: ((context, index) {
                //       return Container(
                //         color: Colors.pink,
                //         width: 40,
                //         height: 50,
                //       );
                //     }),
                //     separatorBuilder: ((context, index) {
                //       return const Divider();
                //     }),
                //     itemCount: productState.products!.length,
                //   ),
                // )
              },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
