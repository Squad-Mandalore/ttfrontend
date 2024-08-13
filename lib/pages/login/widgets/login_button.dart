import 'package:flutter/material.dart';
import '../../../modules/widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomButton(
      buttonText: 'Anmelden',
      buttonColour: theme.colorScheme.primary,
      buttonHeight: 50,
      buttonWidth: 313,
      textSize: 20,
      iconData: Icons.login,
      onTap: onPressed,
    );
  }
}
