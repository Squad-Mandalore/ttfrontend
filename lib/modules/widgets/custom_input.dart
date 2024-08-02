import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/colours.dart';

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
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.width,
    this.height,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextField(
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AppColours.inputBoxDark, // Text colour
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColours.darkAccent4,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColours.inputBoxDark, // Hint Text colour
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
              color: AppColours.borderColourDark, // Unfocused border colour
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColours.borderColourDark, // Focused border colour
            ),
          ),
        ),
      ),
    );
  }
}
