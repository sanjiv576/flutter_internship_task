import 'package:online_store/features/product/presentation/view/nav_bar/homepage_view.dart';
import 'package:online_store/features/splash/presentation/view/splash_view.dart';

import '../../features/product/presentation/view/bottom_navigation_view.dart';
import '../../features/product/presentation/view/nav_bar/home_view.dart';
import '../../features/product/presentation/view/nav_bar/search_view.dart';
import '../../features/product/presentation/view/singel_product_view.dart';

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
      homeRoute: (context) => const HomepageView(),
      singleProductRoute: (context) => const SingleProductView(),
      navigationRoute: (context) => const BottomNavigationView(),
      searchRoute: (context) => const SearchView(),
      splashRoute: (context) => const SplashView(),
    };
  }
}
