import 'package:flutter/material.dart';
import '../../../modules/widgets/custom_button.dart';

class ChangePasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ChangePasswordButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomButton(
      buttonText: 'Passwort Ändern',
      buttonColour: theme.colorScheme.primary,
      buttonHeight: 50,
      buttonWidth: 313,
      textSize: 20,
      onTap: onPressed,
    );
  }
}
