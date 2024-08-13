import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import '../../../modules/utilities/custom_painter_login.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 230,
          child: CustomPaint(
            painter: HeaderPainter(
              backgroundColor:
                  customColors?.primaryColor ?? theme.colorScheme.primary,
            ),
          ),
        ),
        Text.rich(
          TextSpan(
            text: "Schmidt’s\n",
            style: TextStyle(
              fontFamily: 'ntn',
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onPrimary,
              fontSize: 40, // Larger font size for "Schmidt’s"
            ),
            children: [
              TextSpan(
                text: "Handwerksbetrieb",
                style: TextStyle(
                  fontFamily: 'ntn',
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onPrimary,
                  fontSize: 32, // Smaller font size for "Handwerksbetrieb"
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
