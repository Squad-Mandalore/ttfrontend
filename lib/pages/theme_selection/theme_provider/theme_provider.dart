import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String selectedTheme = 'BaumarktRot'; // Default theme

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme {
    return getLightTheme(selectedTheme);
  }

  ThemeData get darkTheme {
    return getDarkTheme(selectedTheme);
  }

  ThemeData getLightTheme(String themeKey) {
    switch (themeKey) {
      case 'TelekomFunk':
        return AppTheme.lightTelekomFunk();
      case 'HardworkingBrown':
        return AppTheme.lightHardworkingBrown();
      case 'PeasentBlue':
        return AppTheme.lightPeasentBlue();
      case 'GrassyFields':
        return AppTheme.lightGrassyFields();
      case 'BaumarktRot':
        return AppTheme.lightBaumarktRot();
      case 'SchmidtBrand':
        return AppTheme.lightSchmidtBrand();
      default:
        return AppTheme.lightBaumarktRot(); // Default light theme
    }
  }

  ThemeData getDarkTheme(String themeKey) {
    switch (themeKey) {
      case 'TelekomFunk':
        return AppTheme.darkTelekomFunk();
      case 'HardworkingBrown':
        return AppTheme.darkHardworkingBrown();
      case 'PeasentBlue':
        return AppTheme.darkPeasentBlue();
      case 'GrassyFields':
        return AppTheme.darkGrassyFields();
      case 'BaumarktRot':
        return AppTheme.darkBaumarktRot();
      case 'SchmidtBrand':
        return AppTheme.darkSchmidtBrand();
      default:
        return AppTheme.darkSchmidtBrand(); // Default dark theme
    }
  }

  String getCurrentThemeKey() {
    return selectedTheme;
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setTheme(String theme) {
    selectedTheme = theme;
    notifyListeners();
  }
}
