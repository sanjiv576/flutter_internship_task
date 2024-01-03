import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../failure/failure.dart';

final appThemePrefsProvider = Provider((ref) => AppThemePrefs());

class AppThemePrefs {
  late SharedPreferences _sharedPreferences;

// set dark theme in shared preferences
  Future<Either<Failure, bool>> setTheme(bool value) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      // set value
      _sharedPreferences.setBool('isDarkTheme', value);
      return const Right(true);
    } catch (err) {
      return Left(Failure(error: 'Error: $err'));
    }
  }

  // get dark theme value from shared prefs
  Future<Either<Failure, bool>> getTheme() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // retrieve the data
      final isDark = _sharedPreferences.getBool('isDarkTheme') ?? false;
      return Right(isDark);
    } catch (err) {
      return Left(Failure(error: 'Error: $err'));
    }
  }
}
