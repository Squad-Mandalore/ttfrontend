import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/colours.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

class AppTheme {
  static DropdownMenuThemeData _dropdownMenuTheme(ColorScheme colorScheme) {
    return DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: colorScheme.surface,
      ),
    );
  }

  static ThemeData lightTelekomFunk() {
    const colorScheme = ColorScheme.light(
      primary: AppColours.greenPrimary,
      secondary: AppColours.magenta,
      surface: AppColours.bgLight,
      onSurface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: AppColours.greenPrimary,
          appBarColor: AppColours.greenPrimary,
          primaryAccent1: AppColours.greenAccent1,
          primaryAccent2: AppColours.greenAccent2,
          primaryAccent3: AppColours.greenAccent3,
          primaryAccent4: AppColours.greenAccent4,
          primaryAccent5: AppColours.greenAccent5,
          primaryAccent6: AppColours.greenAccent6,
          primaryAccent7: AppColours.greenAccent7,
          primaryAccent8: AppColours.greenAccent8,
          primaryAccent9: AppColours.greenAccent9,
          primaryAccent10: AppColours.greenAccent10,
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100,
          backgroundAccent2: Colors.grey.shade200,
          backgroundAccent3: Colors.grey.shade300,
          backgroundAccent4: Colors.grey.shade400,
          backgroundAccent5: Colors.grey.shade500,
          backgroundAccent6: Colors.grey.shade600,
          backgroundAccent7: Colors.grey.shade700,
          backgroundAccent8: Colors.grey.shade800,
          backgroundAccent9: Colors.grey.shade900,
          backgroundAccent10: Colors.black,
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
          bigButtonColor: AppColours.greenPrimary,
          bigButtonHighlightBoxColor: AppColours.greenAccent3,
          bigButtonPauseColor: AppColours.greenAccent9,
          bigButtonStopColor: AppColours.magenta,
          popupBackgroundColor: AppColours.bgLight,
        ),
      ],
    );
  }

  static ThemeData darkTelekomFunk() {
    const colorScheme = ColorScheme.dark(
      primary: AppColours.greenPrimary,
      secondary: AppColours.magenta,
      surface: AppColours.bgDark,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: AppColours.greenPrimary,
          appBarColor: Colors.grey.shade900,
          primaryAccent1: AppColours.greenAccent10,
          primaryAccent2: AppColours.greenAccent9,
          primaryAccent3: AppColours.greenAccent8,
          primaryAccent4: AppColours.greenAccent7,
          primaryAccent5: AppColours.greenAccent6,
          primaryAccent6: AppColours.greenAccent5,
          primaryAccent7: AppColours.greenAccent4,
          primaryAccent8: AppColours.greenAccent3,
          primaryAccent9: AppColours.greenAccent2,
          primaryAccent10: AppColours.greenAccent1,
          backgroundColor: AppColours.bgDark,
          backgroundAccent1: AppColours.darkAccent1,
          backgroundAccent2: AppColours.darkAccent2,
          backgroundAccent3: AppColours.darkAccent3,
          backgroundAccent4: AppColours.darkAccent4,
          backgroundAccent5: AppColours.darkAccent5,
          backgroundAccent6: AppColours.darkAccent6,
          backgroundAccent7: AppColours.darkAccent7,
          backgroundAccent8: AppColours.darkAccent8,
          backgroundAccent9: AppColours.darkAccent9,
          backgroundAccent10: AppColours.darkAccent10,
          inputBoxColor: AppColours.inputBoxDark,
          borderColor: AppColours.borderColourDark,
          bigButtonColor: AppColours.greenPrimary,
          bigButtonHighlightBoxColor: AppColours.greenAccent5,
          bigButtonPauseColor: AppColours.greenAccent9,
          bigButtonStopColor: AppColours.magenta,
          popupBackgroundColor: const Color(0xFF242424),
        ),
      ],
    );
  }

  static ThemeData lightHardworkingBrown() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF723a11),
      secondary: Color(0xFFb79987),
      surface: AppColours.bgLight,
      onSurface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFF723a11),
          appBarColor: const Color(0xFF723a11),
          primaryAccent1: const Color(0xFF804e29),
          primaryAccent2: const Color(0xFF8e6141),
          primaryAccent3: const Color(0xFF9c7558),
          primaryAccent4: const Color(0xFFaa8970),
          primaryAccent5: const Color(0xFFb99d88),
          primaryAccent6: const Color(0xFFc7b0a0),
          primaryAccent7: const Color(0xFFd5c4b8),
          primaryAccent8: const Color(0xFFe3d8cf),
          primaryAccent9: const Color(0xFFf1ebe7),
          primaryAccent10: const Color(0xFFffffff),
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100,
          backgroundAccent2: Colors.grey.shade200,
          backgroundAccent3: Colors.grey.shade300,
          backgroundAccent4: Colors.grey.shade400,
          backgroundAccent5: Colors.grey.shade500,
          backgroundAccent6: Colors.grey.shade600,
          backgroundAccent7: Colors.grey.shade700,
          backgroundAccent8: Colors.grey.shade800,
          backgroundAccent9: Colors.grey.shade900,
          backgroundAccent10: Colors.black,
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
          bigButtonColor: const Color(0xFF723a11),
          bigButtonHighlightBoxColor: const Color(0xFFaa8970),
          bigButtonPauseColor: const Color(0xFF804e29),
          bigButtonStopColor: const Color.fromARGB(255, 114, 17, 17),
          popupBackgroundColor: const Color(0xFFe3d8cf),
        ),
      ],
    );
  }

  static ThemeData darkHardworkingBrown() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFF723a11),
      secondary: Color(0xFF3F2513),
      surface: AppColours.bgDark,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFF723a11),
          appBarColor: const Color(0xFF723a11),
          primaryAccent1: const Color(0xFF67340f),
          primaryAccent2: const Color(0xFF5b2e0e),
          primaryAccent3: const Color(0xFF50290c),
          primaryAccent4: const Color(0xFF44230a),
          primaryAccent5: const Color(0xFF67340f),
          primaryAccent6: const Color(0xFF2e1707),
          primaryAccent7: const Color(0xFF221105),
          primaryAccent8: const Color(0xFF170c03),
          primaryAccent9: const Color(0xFF0b0602),
          primaryAccent10: const Color(0xFF000000),
          backgroundColor: AppColours.bgDark,
          backgroundAccent1: AppColours.darkAccent1,
          backgroundAccent2: AppColours.darkAccent2,
          backgroundAccent3: AppColours.darkAccent3,
          backgroundAccent4: AppColours.darkAccent4,
          backgroundAccent5: AppColours.darkAccent5,
          backgroundAccent6: AppColours.darkAccent6,
          backgroundAccent7: AppColours.darkAccent7,
          backgroundAccent8: AppColours.darkAccent8,
          backgroundAccent9: AppColours.darkAccent9,
          backgroundAccent10: AppColours.darkAccent10,
          inputBoxColor: AppColours.inputBoxDark,
          borderColor: AppColours.borderColourDark,
          bigButtonColor: const Color(0xFF723a11),
          bigButtonHighlightBoxColor: const Color(0xFF2e1707),
          bigButtonPauseColor: const Color(0xFF67340f),
          bigButtonStopColor: const Color.fromARGB(255, 114, 17, 17),
          popupBackgroundColor: const Color(0xFF242424),
        ),
      ],
    );
  }

  static ThemeData lightPeasentBlue() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF247cbc),
      secondary: Color(0xFF8CBCDC),
      surface: AppColours.bgLight,
      onSurface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFF247cbc),
          appBarColor: const Color(0xFF247cbc),
          primaryAccent1: const Color(0xFF3a89c3),
          primaryAccent2: const Color(0xFF5096c9),
          primaryAccent3: const Color(0xFF66a3d0),
          primaryAccent4: const Color(0xFF7cb0d7),
          primaryAccent5: const Color(0xFF92bede),
          primaryAccent6: const Color(0xFFa7cbe4),
          primaryAccent7: const Color(0xFFbdd8eb),
          primaryAccent8: const Color(0xFFd3e5f2),
          primaryAccent9: const Color(0xFFe9f2f8),
          primaryAccent10: const Color(0xFFffffff),
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100,
          backgroundAccent2: Colors.grey.shade200,
          backgroundAccent3: Colors.grey.shade300,
          backgroundAccent4: Colors.grey.shade400,
          backgroundAccent5: Colors.grey.shade500,
          backgroundAccent6: Colors.grey.shade600,
          backgroundAccent7: Colors.grey.shade700,
          backgroundAccent8: Colors.grey.shade800,
          backgroundAccent9: Colors.grey.shade900,
          backgroundAccent10: Colors.black,
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
          bigButtonColor: const Color(0xFF247cbc),
          bigButtonHighlightBoxColor: const Color(0xFF7cb0d7),
          bigButtonPauseColor: const Color(0xFF3a89c3),
          bigButtonStopColor: const Color.fromARGB(255, 188, 36, 36),
          popupBackgroundColor: const Color(0xFFd3e5f2),
        ),
      ],
    );
  }

  static ThemeData darkPeasentBlue() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFF247cbc),
      secondary: Color(0xFF13435F),
      surface: AppColours.bgDark,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFF247cbc),
          appBarColor: const Color(0xFF247cbc),
          primaryAccent1: const Color(0xFF2070a9),
          primaryAccent2: const Color(0xFF1d6396),
          primaryAccent3: const Color(0xFF195784),
          primaryAccent4: const Color(0xFF164a71),
          primaryAccent5: const Color(0xFF123e5e),
          primaryAccent6: const Color(0xFF0e324b),
          primaryAccent7: const Color(0xFF0b2538),
          primaryAccent8: const Color(0xFF071926),
          primaryAccent9: const Color(0xFF040c13),
          primaryAccent10: const Color(0xFF000000),
          backgroundColor: AppColours.bgDark,
          backgroundAccent1: AppColours.darkAccent1,
          backgroundAccent2: AppColours.darkAccent2,
          backgroundAccent3: AppColours.darkAccent3,
          backgroundAccent4: AppColours.darkAccent4,
          backgroundAccent5: AppColours.darkAccent5,
          backgroundAccent6: AppColours.darkAccent6,
          backgroundAccent7: AppColours.darkAccent7,
          backgroundAccent8: AppColours.darkAccent8,
          backgroundAccent9: AppColours.darkAccent9,
          backgroundAccent10: AppColours.darkAccent10,
          inputBoxColor: AppColours.inputBoxDark,
          borderColor: AppColours.borderColourDark,
          bigButtonColor: const Color(0xFF247cbc),
          bigButtonHighlightBoxColor: const Color(0xFF0e324b),
          bigButtonPauseColor: const Color(0xFF2070a9),
          bigButtonStopColor: const Color.fromARGB(255, 188, 36, 36),
          popupBackgroundColor: const Color(0xFF242424),
        ),
      ],
    );
  }

  static ThemeData lightGrassyFields() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF587504),
      secondary: Color(0xFFA8B683),
      surface: AppColours.bgLight,
      onSurface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFF587504),
          appBarColor:  const Color(0xFF587504),
          primaryAccent1: const Color(0xFF69831d),
          primaryAccent2: const Color(0xFF799136),
          primaryAccent3: const Color(0xFF8a9e4f),
          primaryAccent4: const Color(0xFF9bac68),
          primaryAccent5: const Color(0xFFacba82),
          primaryAccent6: const Color(0xFFbcc89b),
          primaryAccent7: const Color(0xFFcdd6b4),
          primaryAccent8: const Color(0xFFdee3cd),
          primaryAccent9: const Color(0xFFeef1e6),
          primaryAccent10: const Color(0xFFffffff),
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100,
          backgroundAccent2: Colors.grey.shade200,
          backgroundAccent3: Colors.grey.shade300,
          backgroundAccent4: Colors.grey.shade400,
          backgroundAccent5: Colors.grey.shade500,
          backgroundAccent6: Colors.grey.shade600,
          backgroundAccent7: Colors.grey.shade700,
          backgroundAccent8: Colors.grey.shade800,
          backgroundAccent9: Colors.grey.shade900,
          backgroundAccent10: Colors.black,
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
          bigButtonColor: const Color(0xFF587504),
          bigButtonHighlightBoxColor: const Color(0xFF9bac68),
          bigButtonPauseColor: const Color(0xFF69831d),
          bigButtonStopColor: const Color.fromARGB(255, 117, 4, 4),
          popupBackgroundColor: const Color(0xFFdee3cd),
        ),
      ],
    );
  }

  static ThemeData darkGrassyFields() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFF587504),
      secondary: Color(0xFF32400b),
      surface: AppColours.bgDark,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFF587504),
          appBarColor: const Color(0xFF587504),
          primaryAccent1: const Color(0xFF4f6904),
          primaryAccent2: const Color(0xFF465e03),
          primaryAccent3: const Color(0xFF3e5203),
          primaryAccent4: const Color(0xFF354602),
          primaryAccent5: const Color(0xFF2c3b02),
          primaryAccent6: const Color(0xFF232f02),
          primaryAccent7: const Color(0xFF1a2301),
          primaryAccent8: const Color(0xFF121701),
          primaryAccent9: const Color(0xFF090c00),
          primaryAccent10: const Color(0xFF000000),
          backgroundColor: AppColours.bgDark,
          backgroundAccent1: AppColours.darkAccent1,
          backgroundAccent2: AppColours.darkAccent2,
          backgroundAccent3: AppColours.darkAccent3,
          backgroundAccent4: AppColours.darkAccent4,
          backgroundAccent5: AppColours.darkAccent5,
          backgroundAccent6: AppColours.darkAccent6,
          backgroundAccent7: AppColours.darkAccent7,
          backgroundAccent8: AppColours.darkAccent8,
          backgroundAccent9: AppColours.darkAccent9,
          backgroundAccent10: AppColours.darkAccent10,
          inputBoxColor: AppColours.inputBoxDark,
          borderColor: AppColours.borderColourDark,
          bigButtonColor: const Color(0xFF587504),
          bigButtonHighlightBoxColor: const Color(0xFF232f02),
          bigButtonPauseColor: const Color(0xFF4f6904),
          bigButtonStopColor: const Color.fromARGB(255, 117, 4, 4),
          popupBackgroundColor: const Color(0xFF242424),
        ),
      ],
    );
  }

  static ThemeData lightBaumarktRot() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFFA50D0D),
      secondary: Color(0xFFD48385),
      surface: AppColours.bgLight,
      onSurface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFFA50D0D),
          appBarColor: const Color(0xFFA50D0D),
          primaryAccent1: const Color(0xFFAE2525),
          primaryAccent2: const Color(0xFFB73D3D),
          primaryAccent3: const Color(0xFFC05656),
          primaryAccent4: const Color(0xFFC96E6E),
          primaryAccent5: const Color(0xFFD28686),
          primaryAccent6: const Color(0xFFDB9E9E),
          primaryAccent7: const Color(0xFFE4B6B6),
          primaryAccent8: const Color(0xFFEDCFCF),
          primaryAccent9: const Color(0xFFF6E7E7),
          primaryAccent10: const Color(0xFFFFEFEF),
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100,
          backgroundAccent2: Colors.grey.shade200,
          backgroundAccent3: Colors.grey.shade300,
          backgroundAccent4: Colors.grey.shade400,
          backgroundAccent5: Colors.grey.shade500,
          backgroundAccent6: Colors.grey.shade600,
          backgroundAccent7: Colors.grey.shade700,
          backgroundAccent8: Colors.grey.shade800,
          backgroundAccent9: Colors.grey.shade900,
          backgroundAccent10: Colors.black,
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
          bigButtonColor: const Color(0xFFC05656),
          bigButtonHighlightBoxColor: const Color(0xFFDB9E9E),
          bigButtonPauseColor: const Color(0xFFC05656),
          bigButtonStopColor: const Color(0xFFAE2525),
          popupBackgroundColor: const Color(0xFFEDCFCF),
        ),
      ],
    );
  }

  static ThemeData darkBaumarktRot() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFFA50D0D),
      secondary: Color(0xFF570711),
      surface: AppColours.bgDark,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFFA50D0D),
          appBarColor: const Color(0xFFA50D0D),
          primaryAccent1: const Color(0xFF950C0C),
          primaryAccent2: const Color(0xFF840A0A),
          primaryAccent3: const Color(0xFF730909),
          primaryAccent4: const Color(0xFF630808),
          primaryAccent5: const Color(0xFF530707),
          primaryAccent6: const Color(0xFF420505),
          primaryAccent7: const Color(0xFF310404),
          primaryAccent8: const Color(0xFF210303),
          primaryAccent9: const Color(0xFF100101),
          primaryAccent10: const Color(0xFF000000),
          backgroundColor: AppColours.bgDark,
          backgroundAccent1: AppColours.darkAccent1,
          backgroundAccent2: AppColours.darkAccent2,
          backgroundAccent3: AppColours.darkAccent3,
          backgroundAccent4: AppColours.darkAccent4,
          backgroundAccent5: AppColours.darkAccent5,
          backgroundAccent6: AppColours.darkAccent6,
          backgroundAccent7: AppColours.darkAccent7,
          backgroundAccent8: AppColours.darkAccent8,
          backgroundAccent9: AppColours.darkAccent9,
          backgroundAccent10: AppColours.darkAccent10,
          inputBoxColor: AppColours.inputBoxDark,
          borderColor: AppColours.borderColourDark,
          bigButtonColor: const Color(0xFF730909),
          bigButtonHighlightBoxColor: const Color(0xFF420505),
          bigButtonPauseColor: const Color(0xFF730909),
          bigButtonStopColor: const Color(0xFFAE2525),
          popupBackgroundColor: const Color(0xFF242424),
        ),
      ],
    );
  }

  static ThemeData lightSchmidtBrand() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFFD78521),
      secondary: Color(0xFFF2D396),
      surface: Colors.white,
      onSurface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFFDE1A1A),
          appBarColor:const Color(0xFFD78521),
          primaryAccent1: const Color(0xFFD78521),
          primaryAccent2: const Color(0xFFD78521),
          primaryAccent3: const Color(0xFFD78521),
          primaryAccent4: const Color(0xFFD78521),
          primaryAccent5: const Color(0xFFD78521),
          primaryAccent6: const Color(0xFFF6CE9E),
          primaryAccent7: const Color(0xFFF6CE9E),
          primaryAccent8: const Color(0xFFF6CE9E),
          primaryAccent9: const Color(0xFFF6CE9E),
          primaryAccent10: const Color(0xFFF6CE9E),
          backgroundColor: Colors.white,
          backgroundAccent1: Colors.grey.shade100,
          backgroundAccent2: Colors.grey.shade200,
          backgroundAccent3: Colors.grey.shade300,
          backgroundAccent4: Colors.grey.shade400,
          backgroundAccent5: Colors.grey.shade500,
          backgroundAccent6: Colors.grey.shade600,
          backgroundAccent7: Colors.grey.shade700,
          backgroundAccent8: Colors.grey.shade800,
          backgroundAccent9: Colors.grey.shade900,
          backgroundAccent10: Colors.black,
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
          bigButtonColor: const Color(0xFFD78521),
          bigButtonHighlightBoxColor: const Color.fromARGB(255, 148, 163, 185),
          bigButtonPauseColor: const Color(0xFFD78521),
          bigButtonStopColor: const Color(0xFFDE1A1A),
          popupBackgroundColor: const Color(0xFFACBDD9),
        ),
      ],
    );
  }

  static ThemeData darkSchmidtBrand() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFFD78521),
      secondary: Color(0xFFF6CE9E),
      surface: AppColours.bgDark,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary, // Set to primary color
        selectedItemColor: colorScheme.onPrimary, // Typically white
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.6), // Slightly transparent
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.6),
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [
        CustomThemeExtension(
          headerColor: const Color(0xFFDE1A1A),
          appBarColor:  AppColours.darkAccent7,
          primaryAccent1: const Color(0xFFD78521),
          primaryAccent2: const Color(0xFFD78521),
          primaryAccent3: const Color(0xFFD78521),
          primaryAccent4: const Color(0xFFD78521),
          primaryAccent5: const Color(0xFFD78521),
          primaryAccent6: const Color(0xFFF6CE9E),
          primaryAccent7: const Color(0xFFF6CE9E),
          primaryAccent8: const Color(0xFFF6CE9E),
          primaryAccent9: const Color(0xFFF6CE9E),
          primaryAccent10: const Color(0xFFF6CE9E),
          backgroundColor: AppColours.bgDark,
          backgroundAccent1: AppColours.darkAccent1,
          backgroundAccent2: AppColours.darkAccent2,
          backgroundAccent3: AppColours.darkAccent3,
          backgroundAccent4: AppColours.darkAccent4,
          backgroundAccent5: AppColours.darkAccent5,
          backgroundAccent6: AppColours.darkAccent6,
          backgroundAccent7: AppColours.darkAccent7,
          backgroundAccent8: AppColours.darkAccent8,
          backgroundAccent9: AppColours.darkAccent9,
          backgroundAccent10: AppColours.darkAccent10,
          inputBoxColor: AppColours.inputBoxDark,
          borderColor: AppColours.borderColourDark,
          bigButtonColor: const Color(0xFFD78521),
          bigButtonHighlightBoxColor: const Color.fromARGB(255, 90, 99, 112),
          bigButtonPauseColor: const Color(0xFFD78521),
          bigButtonStopColor: const Color(0xFFDE1A1A),
          popupBackgroundColor: const Color(0xFF242424),
        ),
      ],
    );
  }
}
