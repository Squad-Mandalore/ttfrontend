import 'package:flutter/material.dart';
import '../../../assets/colours/colours.dart';
import '../../../modules/utilities/custom_painter_login.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 230,
          child: CustomPaint(
            painter: HeaderPainter(backgroundColor: AppColours.greenPrimary),
          ),
        ),
        const Text(
          'Schmidt’s \nHandwerksbetrieb',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ntn',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ],
    );
  }
}
