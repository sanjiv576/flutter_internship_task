import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/utils/device_size.dart';

import '../services/networking.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  double width = DeviceSize.width;
  double height = DeviceSize.height;

  late List<dynamic>? _products;

  final _searchController = TextEditingController();

  List<dynamic> _filteredProducts = [];

  bool _isInitializeSearching = false;

  final _verticalGap = const SizedBox(height: 30);
  final _horizontalGap = const SizedBox(width: 20);

  final List<bool> _isSelected = List.generate(12, (index) => false);

  @override
  void initState() {
    getProductData();
    _searchController.addListener(_onSearching);
    super.initState();
  }

  void _onSearching() {
    final searchQuery = _searchController.text.trim().toLowerCase();
    if (searchQuery.isEmpty) {
      setState(() {
        _isInitializeSearching = false;
        _filteredProducts = [];
      });
    } else {
      setState(() {
        _isInitializeSearching = true;
        // Filter products by name or category
        _filteredProducts = _products!
            .where((product) =>
                product.title.toLowerCase().contains(searchQuery) ||
                product.category.toLowerCase().contains(searchQuery))
            .toList();
      });
    }
  }

  Future<void> getProductData() async {
    OnlineStore onlineStore =
        OnlineStore(url: 'https://fakestoreapi.com/products');

    var products = await onlineStore.fetchProductData();

    if (products != null) {
      for (int i = 0; i < products.length; i++) {
        print('id: ${products[i].id}');
        print('Product ${i + 1}: ${products[i]}');
        print('---------------');
      }

      setState(() {
        _products = products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(
                controller: _searchController,
                leading: const Icon(Icons.search),
                hintText: 'Enter product by name or category',
              ),
              _verticalGap,
              Expanded(
                child: _isInitializeSearching
                    ? ListView.builder(
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          var singleProduct = _filteredProducts[index];
                          return GestureDetector(
                              onTap: () {
                                print('Product name ; ${singleProduct.title}');
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        NetworkImage(singleProduct.image),
                                  ),
                                  title: Text(
                                    (singleProduct.title as String)
                                        .substring(0, 10),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8.0),
                                      Text(
                                        singleProduct.category,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${singleProduct.price}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isSelected[singleProduct.id] =
                                                    true;
                                              });
                                            },
                                            child: _isSelected[singleProduct.id]
                                                ? const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : const Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.red,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      )
                    : const Center(
                        child: Text('No data'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Widget leading;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.leading,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
