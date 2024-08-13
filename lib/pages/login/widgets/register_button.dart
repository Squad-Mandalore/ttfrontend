import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import '../../../modules/widgets/custom_button.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return CustomButton(
      buttonText: 'Registrieren',
      buttonColour: customColors?.secondaryColor ?? theme.colorScheme.secondary,
      buttonHeight: 50,
      buttonWidth: 313,
      textSize: 20,
    );
  }
}
