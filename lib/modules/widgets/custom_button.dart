import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color buttonColour;
  final IconData? iconData;
  final double buttonHeight;
  final double? buttonWidth;
  final double textSize;
  final Color? borderColor;

  const CustomButton({
    super.key,
    this.buttonText,
    required this.buttonColour,
    this.iconData,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.textSize,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white; // Use text color from theme

    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: buttonColour,
            border: Border.all(
              color: borderColor ?? buttonColour,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null)
                  Icon(
                    iconData,
                    color: textColor, // Use theme-based text color
                  ),
                if (iconData != null && buttonText != null)
                  const SizedBox(width: 10),
                if (buttonText != null)
                  Text(
                    buttonText!,
                    style: TextStyle(
                      fontSize: textSize,
                      color: textColor, // Use theme-based text color
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
