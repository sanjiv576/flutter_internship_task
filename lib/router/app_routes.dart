import 'package:flutter/material.dart';
import 'package:online_store/views/bottom_navigation_view.dart';

import '../views/home_view.dart';
import '../views/singel_product_view.dart';

class AppRoutes {
  // avoid making constructor
  AppRoutes._();

  static const String homeRoute = '/';
  static const String navigationRoute = '/home';
  static const String shoppingCartRoute = '/shoppingCart';
  static const String singleProductRoute = '/singleProduct';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      singleProductRoute: (context) => const SingleProductView(),
      navigationRoute: (context) => const BottomNavigationView()
    };
  }
}
