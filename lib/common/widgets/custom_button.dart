import 'package:flutter/material.dart';

class ButtonWide extends StatelessWidget {
  final String? buttonText;
  final Color buttonColour;
  final IconData? iconData;
  final double buttonHeight;
  final double buttonWidth;
  final double textSize;

  const ButtonWide({
    Key? key,
    this.buttonText,
    required this.buttonColour,
    this.iconData,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null)
                  Icon(
                    iconData,
                    color: Colors.white,
                  ),
                if (iconData != null && buttonText != null)
                  SizedBox(width: 10),
                if (buttonText != null)
                  Text(
                    buttonText!,
                    style: TextStyle(
                      fontSize: textSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
