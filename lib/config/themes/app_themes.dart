import 'package:flutter/material.dart';

import 'widget_themes/text_themes.dart';

class AppThemes {
  static appLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        textTheme: KTextThemes.lightTextThemes(),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ));
  }

  static appDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: KTextThemes.darkTextTheme(),
        iconTheme: const IconThemeData(color: Colors.white),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF282C3B),
        colorScheme: const ColorScheme.dark(background: Colors.yellow));
  }
}
