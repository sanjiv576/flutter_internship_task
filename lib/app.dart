import 'package:flutter/material.dart';
import 'package:online_store/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.navigationRoute,
    );
  }
}
