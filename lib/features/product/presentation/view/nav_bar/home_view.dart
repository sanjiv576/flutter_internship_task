import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data_source/remote/networking.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../../widget/categories_widget.dart';
import '../../widget/product_card_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeView> {
  // var _products;

  late double width;
  late double height;
  String categoryUrl = 'https://fakestoreapi.com/products/categories';
  late Future<List<dynamic>>? _categoriesFuture;

  late Future<List<dynamic>>? _products;

  @override
  void initState() {
    super.initState();

    _products = getProductData();
    _categoriesFuture = getCategoryData();
  }

  Future<List<dynamic>> getCategoryData() async {
    try {
      OnlineStore onlineStore = OnlineStore(url: categoryUrl);
      List<dynamic> categories = await onlineStore.fetchCategoryData();
      log('Category length: ${categories.length}');
      return categories;
    } catch (err) {
      log('Error ca: $err');
      return []; // Handle the error appropriately
    }
  }

  Future<List<dynamic>> getProductData() async {
    OnlineStore onlineStore =
        OnlineStore(url: 'https://fakestoreapi.com/products');

    var products = await onlineStore.fetchProductData();

    if (products != null) {
      // for (int i = 0; i < products.length; i++) {
      //   print('id: ${products[i].id}');
      //   print('Product ${i + 1}: ${products[i]}');
      //   print('---------------');
      // }

      // _products = products;
      return products;
    }
    return [];
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
      log('Total len of products from clean arch: ${productState.products!.length}');
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            children: [
              Column(
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
                  CategoriesWidget(
                    categoriesFuture: _categoriesFuture,
                    horizontalGap: _horizontalGap,
                    verticalGap: const SizedBox(
                      height: 10,
                    ),
                  ),
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
                ],
              ),
              _verticalGap,
              Expanded(
                // flex: 4,
                child: FutureBuilder<List<dynamic>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No products available.');
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // no. of columns in the grid
                          crossAxisSpacing: 16.0, // spacing between columns
                          mainAxisSpacing: 8.0, // spacing between rows
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var product = snapshot.data![index];

                          return ProductCard(product: product);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
