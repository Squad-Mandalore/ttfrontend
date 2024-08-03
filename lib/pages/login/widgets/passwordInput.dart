import 'package:flutter/material.dart';
import '../../../modules/widgets/custom_input.dart';

class PasswordInput extends StatelessWidget {
  final FocusNode focusNode;

  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 260,
          alignment: Alignment.centerLeft,
          child: Text(
            'Passwort',
            style: TextStyle(
              fontFamily: 'ntn',
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomInput(
          focusNode: focusNode,
          hintText: 'Passwort',
          width: 270,
          height: 60,
        )
      ],
    );
  }
}
