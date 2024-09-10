
import 'package:flutter/cupertino.dart';

class HeaderPainter extends CustomPainter {
  final Color backgroundColor;

  HeaderPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.85);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
