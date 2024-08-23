import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Divider(
      color: theme.colorScheme.onSurface.withOpacity(0.3),
      thickness: 2,
      indent: 55,
      endIndent: 55,
    );
  }
}
