import 'package:flutter/material.dart';
import '../../../assets/colours/colours.dart';
import '../../../modules/widgets/custom_button.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: 'Registrieren',
      buttonColour: AppColours.magenta,
      buttonHeight: 50,
      buttonWidth: 270,
      textSize: 24,
      borderColor: Colors.white,
    );
  }
}
