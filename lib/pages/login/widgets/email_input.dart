import 'package:flutter/material.dart';
import '../../../modules/widgets/custom_input.dart';

class EmailInput extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  const EmailInput({super.key, required this.focusNode, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 313,
          alignment: Alignment.centerLeft,
          child: Text(
            'E-Mail',
            style: TextStyle(
              fontFamily: 'ntn',
              fontWeight: FontWeight.w300,
              color: theme.colorScheme.onSurface,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 5),
        CustomInput(
          controller: controller,
          focusNode: focusNode,
          hintText: 'Arbeits E-Mail Adresse',
          width: 313,
          height: 60,
        ),
      ],
    );
  }
}
