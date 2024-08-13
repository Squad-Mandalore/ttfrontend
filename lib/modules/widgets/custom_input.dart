import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final double? width;
  final double? height;
  final FocusNode? focusNode;

  const CustomInput({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.width,
    this.height,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: customColors?.borderColor ??
              theme.textTheme.bodyMedium?.color, // Text color
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: customColors?.inputBoxColor ??
              theme.inputDecorationTheme.fillColor,
          hintText: hintText,
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
            fontWeight: FontWeight.w300,
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: customColors?.borderColor ??
                  theme.dividerColor, // Unfocused border color
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: customColors?.borderColor ??
                  theme.primaryColor, // Focused border color
            ),
          ),
        ),
      ),
    );
  }
}
