import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/router/app_routes.dart';
import '../config/themes/app_themes.dart';
import 'common/provider/is_dark_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? AppThemes.appDarkTheme() : AppThemes.appLightTheme(),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.splashRoute,
    );
  }
}
