import 'package:flutter/material.dart';
import 'package:online_store/features/product/domain/entity/product.dart';
import 'package:online_store/features/product/data/data_source/remote/networking.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({super.key});

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  var _product;

  @override
  void didChangeDependencies() {
    _product = ModalRoute.of(context)!.settings.arguments as dynamic;

    print('Prod name: $_product');
    super.didChangeDependencies();
  }

  // Future getSingleProduct() async {
  //   OnlineStore onlineStore =
  //       OnlineStore(url: 'https://fakestoreapi.com/products/${widget.id}');

  //   var data = await onlineStore.fetchSingleProduct();
  //   if (data != null) {
  //     return data;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // url = 'https://fakestoreapi.com/products/${widget.id}';

    // _product = getSingleProduct();
    return const Scaffold(
      body: SafeArea(child: Text('afd')),
    );
  }
}
