import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String selectedTheme = 'BaumarktRot'; // Default theme

  static const String _themeKey = 'selectedTheme';
  static const String _themeModeKey = 'themeMode';

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

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    selectedTheme = prefs.getString(_themeKey) ?? 'BaumarktRot';
    String? mode = prefs.getString(_themeModeKey);

    if (mode != null) {
      switch (mode) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'system':
        default:
          _themeMode = ThemeMode.system;
          break;
      }
    }

    notifyListeners();
  }

  /// Sets the ThemeMode and saves it to SharedPreferences
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
      default:
        modeString = 'system';
        break;
    }
    await prefs.setString(_themeModeKey, modeString);
  }

  /// Sets the theme and saves it to SharedPreferences
  Future<void> setTheme(String theme) async {
    selectedTheme = theme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }
}
