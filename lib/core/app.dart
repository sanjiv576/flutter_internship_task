import 'package:flutter/material.dart';
import 'package:online_store/config/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.splashRoute,
    );
  }
}
