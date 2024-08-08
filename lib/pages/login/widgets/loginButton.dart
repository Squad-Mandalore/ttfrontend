import 'package:flutter/material.dart';
import '../../../assets/colours/colours.dart';
import '../../../modules/widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: 'Anmelden',
      buttonColour: AppColours.greenPrimary,
      buttonHeight: 50,
      buttonWidth: 270,
      textSize: 24,
      iconData: Icons.login,
    );
  }
}
