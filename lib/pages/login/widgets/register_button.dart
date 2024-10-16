import 'package:flutter/material.dart';
import '../../../modules/widgets/custom_button.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomButton(
      buttonText: 'Registrieren',
      buttonColour: theme.colorScheme.secondary,
      buttonHeight: 50,
      buttonWidth: 313,
      textSize: 20,
      onTap: onPressed,
    );
  }
}
