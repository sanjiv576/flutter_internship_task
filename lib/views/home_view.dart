import 'package:flutter/material.dart';
import 'package:online_store/services/networking.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  var _proudcts;

  @override
  void initState() {
    super.initState();

    getProductData();
  }

  void getProductData() async {
    OnlineStore onlineStore = OnlineStore();

    var proudcts = await onlineStore.getData();

    if (proudcts != null) {
      print('Products');
      print(proudcts.length);

      for (int i = 0; i < proudcts.length; i++) {
        print('id: ${proudcts[i]['id']}');
        print('title: ${proudcts[i]['title']}');
        print('price: ${proudcts[i]['price']}');
        print('description: ${proudcts[i]['description']}');
        print('image: ${proudcts[i]['image']}');
        print('ratings: ${proudcts[i]['rating']['rate']}');

        print('-----------------');
      }

      _proudcts = proudcts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('home'),
      ),
    );
  }
}
