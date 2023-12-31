import 'package:online_store/views/splash_view.dart';

import '../views/bottom_navigation_view.dart';
import '../views/home_view.dart';
import '../views/search_view.dart';
import '../views/singel_product_view.dart';

class AppRoutes {
  // avoid making constructor
  AppRoutes._();

  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String navigationRoute = '/navigation';
  static const String shoppingCartRoute = '/shoppingCart';
  static const String searchRoute = '/search';
  static const String singleProductRoute = '/singleProduct';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      singleProductRoute: (context) =>  SingleProductView(),
      navigationRoute: (context) => const BottomNavigationView(),
      searchRoute: (context) => const SearchView(),
      splashRoute: (context) => const SplashView(),
    };
  }
}
