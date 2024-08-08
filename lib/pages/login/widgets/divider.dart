import 'package:flutter/material.dart';
import '../../../assets/colours/colours.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColours.inputBoxDark,
      thickness: 2,
      indent: 50,
      endIndent: 50,
    );
  }
}
