import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import '../../../modules/widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return CustomButton(
      buttonText: 'Anmelden',
      buttonColour: customColors?.primaryColor ?? theme.colorScheme.primary,
      buttonHeight: 50,
      buttonWidth: 313,
      textSize: 20,
      iconData: Icons.login,
    );
  }
}
