import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared_prefs/app_theme_prefs.dart';

// StateNotifier is used because it returns a subclass of StateNotifier of appThemePrefs
final isDarkThemeProvider = StateNotifierProvider<IsDarkTheme, bool>(
    (ref) => IsDarkTheme(ref.watch(appThemePrefsProvider)));

class IsDarkTheme extends StateNotifier<bool> {
  // create an object of appThemePrefs because it can only set and get theme values from the Shared Prefs
  AppThemePrefs appThemePrefs;

  // initially the app has light theme so pass false
  IsDarkTheme(this.appThemePrefs) : super(false) {
    onInit();
  }

  onInit() async {
    // call the get theme method
    final isDark = await appThemePrefs.getTheme();
    // can have failure or bool
    isDark.fold((failed) => state = false, (r) => state = r);
  }

  // update the theme

  updateTheme(bool isDarkTheme) {
    appThemePrefs.setTheme(isDarkTheme);
    // update the state with the current value
    state = isDarkTheme;
  }
}
