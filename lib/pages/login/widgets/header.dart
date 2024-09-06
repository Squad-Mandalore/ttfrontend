import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import '../../../modules/utilities/custom_painter_login.dart';
import 'package:ttfrontend/pages/theme_selection/theme_selection_page.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ThemeSelectionPage(),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 230,
            child: CustomPaint(
              painter: HeaderPainter(
                backgroundColor:
                    customColors?.headerColor ?? theme.colorScheme.primary,
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
                fontSize: 40,
              ),
              children: [
                TextSpan(
                  text: "Handwerksbetrieb",
                  style: TextStyle(
                    fontFamily: 'ntn',
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onPrimary,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
