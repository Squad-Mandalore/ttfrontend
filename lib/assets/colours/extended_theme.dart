import 'package:flutter/material.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color headerColor;
  final Color primaryAccent1;
  final Color primaryAccent2;
  final Color primaryAccent3;
  final Color primaryAccent4;
  final Color primaryAccent5;
  final Color primaryAccent6;
  final Color primaryAccent7;
  final Color primaryAccent8;
  final Color primaryAccent9;
  final Color primaryAccent10;

  final Color backgroundColor;
  final Color backgroundAccent1;
  final Color backgroundAccent2;
  final Color backgroundAccent3;
  final Color backgroundAccent4;
  final Color backgroundAccent5;
  final Color backgroundAccent6;
  final Color backgroundAccent7;
  final Color backgroundAccent8;
  final Color backgroundAccent9;
  final Color backgroundAccent10;

  final Color inputBoxColor;
  final Color borderColor;
  final Color bigButtonColor;
  final Color bigButtonStopColor;
  final Color bigButtonPauseColor;
  final Color bigButtonHighlightBoxColor;

  final Color popupBackgroundColor;

  CustomThemeExtension({
    required this.headerColor,
    required this.primaryAccent1,
    required this.primaryAccent2,
    required this.primaryAccent3,
    required this.primaryAccent4,
    required this.primaryAccent5,
    required this.primaryAccent6,
    required this.primaryAccent7,
    required this.primaryAccent8,
    required this.primaryAccent9,
    required this.primaryAccent10,
    required this.backgroundColor,
    required this.backgroundAccent1,
    required this.backgroundAccent2,
    required this.backgroundAccent3,
    required this.backgroundAccent4,
    required this.backgroundAccent5,
    required this.backgroundAccent6,
    required this.backgroundAccent7,
    required this.backgroundAccent8,
    required this.backgroundAccent9,
    required this.backgroundAccent10,
    required this.inputBoxColor,
    required this.borderColor,
    required this.bigButtonColor,
    required this.bigButtonHighlightBoxColor,
    required this.bigButtonPauseColor,
    required this.bigButtonStopColor,
    required this.popupBackgroundColor,
  });

  @override
  CustomThemeExtension copyWith({
    Color? headerColor,
    Color? primaryAccent1,
    Color? primaryAccent2,
    Color? primaryAccent3,
    Color? primaryAccent4,
    Color? primaryAccent5,
    Color? primaryAccent6,
    Color? primaryAccent7,
    Color? primaryAccent8,
    Color? primaryAccent9,
    Color? primaryAccent10,
    Color? backgroundColor,
    Color? backgroundAccent1,
    Color? backgroundAccent2,
    Color? backgroundAccent3,
    Color? backgroundAccent4,
    Color? backgroundAccent5,
    Color? backgroundAccent6,
    Color? backgroundAccent7,
    Color? backgroundAccent8,
    Color? backgroundAccent9,
    Color? backgroundAccent10,
    Color? inputBoxColor,
    Color? borderColor,
    Color? bigButtonColor,
    Color? bigButtonStopColor,
    Color? bigButtonPauseColor,
    Color? bigButtonHighlightBoxColor,
    Color? popupBackgroundColor,
  }) {
    return CustomThemeExtension(
      headerColor: headerColor ?? this.headerColor,
      primaryAccent1: primaryAccent1 ?? this.primaryAccent1,
      primaryAccent2: primaryAccent2 ?? this.primaryAccent2,
      primaryAccent3: primaryAccent3 ?? this.primaryAccent3,
      primaryAccent4: primaryAccent4 ?? this.primaryAccent4,
      primaryAccent5: primaryAccent5 ?? this.primaryAccent5,
      primaryAccent6: primaryAccent6 ?? this.primaryAccent6,
      primaryAccent7: primaryAccent7 ?? this.primaryAccent7,
      primaryAccent8: primaryAccent8 ?? this.primaryAccent8,
      primaryAccent9: primaryAccent9 ?? this.primaryAccent9,
      primaryAccent10: primaryAccent10 ?? this.primaryAccent10,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundAccent1: backgroundAccent1 ?? this.backgroundAccent1,
      backgroundAccent2: backgroundAccent2 ?? this.backgroundAccent2,
      backgroundAccent3: backgroundAccent3 ?? this.backgroundAccent3,
      backgroundAccent4: backgroundAccent4 ?? this.backgroundAccent4,
      backgroundAccent5: backgroundAccent5 ?? this.backgroundAccent5,
      backgroundAccent6: backgroundAccent6 ?? this.backgroundAccent6,
      backgroundAccent7: backgroundAccent7 ?? this.backgroundAccent7,
      backgroundAccent8: backgroundAccent8 ?? this.backgroundAccent8,
      backgroundAccent9: backgroundAccent9 ?? this.backgroundAccent9,
      backgroundAccent10: backgroundAccent10 ?? this.backgroundAccent10,
      inputBoxColor: inputBoxColor ?? this.inputBoxColor,
      borderColor: borderColor ?? this.borderColor,
      bigButtonColor: bigButtonColor ?? this.bigButtonColor,
      bigButtonStopColor: bigButtonStopColor ?? this.bigButtonStopColor,
      bigButtonPauseColor: bigButtonPauseColor ?? this.bigButtonPauseColor,
      bigButtonHighlightBoxColor:
          bigButtonHighlightBoxColor ?? this.bigButtonHighlightBoxColor,
      popupBackgroundColor: popupBackgroundColor ?? this.popupBackgroundColor,
    );
  }

  @override
  CustomThemeExtension lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      headerColor: Color.lerp(headerColor, other.headerColor, t)!,
      primaryAccent1: Color.lerp(primaryAccent1, other.primaryAccent1, t)!,
      primaryAccent2: Color.lerp(primaryAccent2, other.primaryAccent2, t)!,
      primaryAccent3: Color.lerp(primaryAccent3, other.primaryAccent3, t)!,
      primaryAccent4: Color.lerp(primaryAccent4, other.primaryAccent4, t)!,
      primaryAccent5: Color.lerp(primaryAccent5, other.primaryAccent5, t)!,
      primaryAccent6: Color.lerp(primaryAccent6, other.primaryAccent6, t)!,
      primaryAccent7: Color.lerp(primaryAccent7, other.primaryAccent7, t)!,
      primaryAccent8: Color.lerp(primaryAccent8, other.primaryAccent8, t)!,
      primaryAccent9: Color.lerp(primaryAccent9, other.primaryAccent9, t)!,
      primaryAccent10: Color.lerp(primaryAccent10, other.primaryAccent10, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      backgroundAccent1:
          Color.lerp(backgroundAccent1, other.backgroundAccent1, t)!,
      backgroundAccent2:
          Color.lerp(backgroundAccent2, other.backgroundAccent2, t)!,
      backgroundAccent3:
          Color.lerp(backgroundAccent3, other.backgroundAccent3, t)!,
      backgroundAccent4:
          Color.lerp(backgroundAccent4, other.backgroundAccent4, t)!,
      backgroundAccent5:
          Color.lerp(backgroundAccent5, other.backgroundAccent5, t)!,
      backgroundAccent6:
          Color.lerp(backgroundAccent6, other.backgroundAccent6, t)!,
      backgroundAccent7:
          Color.lerp(backgroundAccent7, other.backgroundAccent7, t)!,
      backgroundAccent8:
          Color.lerp(backgroundAccent8, other.backgroundAccent8, t)!,
      backgroundAccent9:
          Color.lerp(backgroundAccent9, other.backgroundAccent9, t)!,
      backgroundAccent10:
          Color.lerp(backgroundAccent10, other.backgroundAccent10, t)!,
      inputBoxColor: Color.lerp(inputBoxColor, other.inputBoxColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      bigButtonColor: Color.lerp(bigButtonColor, other.bigButtonColor, t)!,
      bigButtonStopColor:
          Color.lerp(bigButtonStopColor, other.bigButtonStopColor, t)!,
      bigButtonPauseColor:
          Color.lerp(bigButtonPauseColor, other.bigButtonPauseColor, t)!,
      bigButtonHighlightBoxColor: Color.lerp(
          bigButtonHighlightBoxColor, other.bigButtonHighlightBoxColor, t)!,
      popupBackgroundColor:
          Color.lerp(popupBackgroundColor, other.popupBackgroundColor, t)!,
    );
  }
}
