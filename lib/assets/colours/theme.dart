import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/colours.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

class AppTheme {
  static ThemeData lightTelekomFunk() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColours.greenPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgLight,
        onSurface: Colors.black,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      extensions: [
        CustomThemeExtension(
          primaryColor: AppColours.greenPrimary,
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
          secondaryColor: AppColours.magenta,
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100, // Customize as needed
          backgroundAccent2: Colors.grey.shade200, // Customize as needed
          backgroundAccent3: Colors.grey.shade300, // Customize as needed
          backgroundAccent4: Colors.grey.shade400, // Customize as needed
          backgroundAccent5: Colors.grey.shade500, // Customize as needed
          backgroundAccent6: Colors.grey.shade600, // Customize as needed
          backgroundAccent7: Colors.grey.shade700, // Customize as needed
          backgroundAccent8: Colors.grey.shade800, // Customize as needed
          backgroundAccent9: Colors.grey.shade900, // Customize as needed
          backgroundAccent10: Colors.black, // Customize as needed
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
        ),
      ],
    );
  }

  static ThemeData darkTelekomFunk() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColours.darkPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgDark,
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      extensions: [
        CustomThemeExtension(
            primaryColor: AppColours.greenPrimary,
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
            secondaryColor: AppColours.magenta,
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
            borderColor: AppColours.borderColourDark),
      ],
    );
  }

  static ThemeData lightHardworkingBrown() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColours.greenPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgLight,
        onSurface: Colors.black,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      extensions: [
        CustomThemeExtension(
          primaryColor: const Color(0xFF723a11),
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
          secondaryColor: const Color(0xFFb79987),
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100, // Customize as needed
          backgroundAccent2: Colors.grey.shade200, // Customize as needed
          backgroundAccent3: Colors.grey.shade300, // Customize as needed
          backgroundAccent4: Colors.grey.shade400, // Customize as needed
          backgroundAccent5: Colors.grey.shade500, // Customize as needed
          backgroundAccent6: Colors.grey.shade600, // Customize as needed
          backgroundAccent7: Colors.grey.shade700, // Customize as needed
          backgroundAccent8: Colors.grey.shade800, // Customize as needed
          backgroundAccent9: Colors.grey.shade900, // Customize as needed
          backgroundAccent10: Colors.black, // Customize as needed
          inputBoxColor: const Color(0xFF252525),
          borderColor: const Color(0xFFD9D9D9),
        ),
      ],
    );
  }

  static ThemeData darkHardworkingBrown() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColours.darkPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgDark,
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      extensions: [
        CustomThemeExtension(
          primaryColor: const Color(0xFF723a11),
          primaryAccent1: const Color(0xFF67340f),
          primaryAccent2: const Color(0xFF5b2e0e),
          primaryAccent3: const Color(0xFF50290c),
          primaryAccent4: const Color(0xFF44230a),
          primaryAccent5: const Color(0xFF391d09),
          primaryAccent6: const Color(0xFF2e1707),
          primaryAccent7: const Color(0xFF221105),
          primaryAccent8: const Color(0xFF170c03),
          primaryAccent9: const Color(0xFF0b0602),
          primaryAccent10: const Color(0xFF000000),
          secondaryColor: const Color(0xFF3F2513),
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
          inputBoxColor: const Color(0xFF252525),
          borderColor: const Color(0xFFD9D9D9),
        ),
      ],
    );
  }

  static ThemeData lightPeasentBlue() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColours.greenPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgLight,
        onSurface: Colors.black,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      extensions: [
        CustomThemeExtension(
          primaryColor: AppColours.greenPrimary,
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
          secondaryColor: AppColours.magenta,
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100, // Customize as needed
          backgroundAccent2: Colors.grey.shade200, // Customize as needed
          backgroundAccent3: Colors.grey.shade300, // Customize as needed
          backgroundAccent4: Colors.grey.shade400, // Customize as needed
          backgroundAccent5: Colors.grey.shade500, // Customize as needed
          backgroundAccent6: Colors.grey.shade600, // Customize as needed
          backgroundAccent7: Colors.grey.shade700, // Customize as needed
          backgroundAccent8: Colors.grey.shade800, // Customize as needed
          backgroundAccent9: Colors.grey.shade900, // Customize as needed
          backgroundAccent10: Colors.black, // Customize as needed
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
        ),
      ],
    );
  }

  static ThemeData darkPeasentBlue() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColours.darkPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgDark,
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      extensions: [
        CustomThemeExtension(
            primaryColor: AppColours.greenPrimary,
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
            secondaryColor: AppColours.magenta,
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
            borderColor: AppColours.borderColourDark),
      ],
    );
  }

  static ThemeData lightGrassyFields() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColours.greenPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgLight,
        onSurface: Colors.black,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      extensions: [
        CustomThemeExtension(
          primaryColor: AppColours.greenPrimary,
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
          secondaryColor: AppColours.magenta,
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100, // Customize as needed
          backgroundAccent2: Colors.grey.shade200, // Customize as needed
          backgroundAccent3: Colors.grey.shade300, // Customize as needed
          backgroundAccent4: Colors.grey.shade400, // Customize as needed
          backgroundAccent5: Colors.grey.shade500, // Customize as needed
          backgroundAccent6: Colors.grey.shade600, // Customize as needed
          backgroundAccent7: Colors.grey.shade700, // Customize as needed
          backgroundAccent8: Colors.grey.shade800, // Customize as needed
          backgroundAccent9: Colors.grey.shade900, // Customize as needed
          backgroundAccent10: Colors.black, // Customize as needed
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
        ),
      ],
    );
  }

  static ThemeData darkGrassyFields() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColours.darkPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgDark,
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      extensions: [
        CustomThemeExtension(
            primaryColor: AppColours.greenPrimary,
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
            secondaryColor: AppColours.magenta,
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
            borderColor: AppColours.borderColourDark),
      ],
    );
  }

  static ThemeData lightBaumarktRot() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColours.greenPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgLight,
        onSurface: Colors.black,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      extensions: [
        CustomThemeExtension(
          primaryColor: const Color(0xFFA50D0D),
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
          secondaryColor: const Color(0xFFD48385),
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100, // Customize as needed
          backgroundAccent2: Colors.grey.shade200, // Customize as needed
          backgroundAccent3: Colors.grey.shade300, // Customize as needed
          backgroundAccent4: Colors.grey.shade400, // Customize as needed
          backgroundAccent5: Colors.grey.shade500, // Customize as needed
          backgroundAccent6: Colors.grey.shade600, // Customize as needed
          backgroundAccent7: Colors.grey.shade700, // Customize as needed
          backgroundAccent8: Colors.grey.shade800, // Customize as needed
          backgroundAccent9: Colors.grey.shade900, // Customize as needed
          backgroundAccent10: Colors.black, // Customize as needed
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
        ),
      ],
    );
  }

  static ThemeData darkBaumarktRot() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColours.darkPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgDark,
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      extensions: [
        CustomThemeExtension(
            primaryColor: const Color(0xFFA50D0D),
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
            secondaryColor: const Color(0xFF570711),
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
            borderColor: AppColours.borderColourDark),
      ],
    );
  }

  static ThemeData lightSchmidtBrand() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColours.greenPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgLight,
        onSurface: Colors.black,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgLight,
      extensions: [
        CustomThemeExtension(
          primaryColor: AppColours.greenPrimary,
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
          secondaryColor: AppColours.magenta,
          backgroundColor: AppColours.bgLight,
          backgroundAccent1: Colors.grey.shade100, // Customize as needed
          backgroundAccent2: Colors.grey.shade200, // Customize as needed
          backgroundAccent3: Colors.grey.shade300, // Customize as needed
          backgroundAccent4: Colors.grey.shade400, // Customize as needed
          backgroundAccent5: Colors.grey.shade500, // Customize as needed
          backgroundAccent6: Colors.grey.shade600, // Customize as needed
          backgroundAccent7: Colors.grey.shade700, // Customize as needed
          backgroundAccent8: Colors.grey.shade800, // Customize as needed
          backgroundAccent9: Colors.grey.shade900, // Customize as needed
          backgroundAccent10: Colors.black, // Customize as needed
          inputBoxColor: AppColours.inputBoxLight,
          borderColor: AppColours.borderColourLight,
        ),
      ],
    );
  }

  static ThemeData darkSchmidtBrand() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColours.darkPrimary,
        secondary: AppColours.magenta,
        surface: AppColours.bgDark,
        onSurface: Colors.white,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ntn',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: AppColours.bgDark,
      extensions: [
        CustomThemeExtension(
            primaryColor: AppColours.greenPrimary,
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
            secondaryColor: AppColours.magenta,
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
            borderColor: AppColours.borderColourDark),
      ],
    );
  }
}
