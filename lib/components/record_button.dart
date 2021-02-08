import 'package:flutter/material.dart';

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(235, 52, 52, 1.0)
      ..style = PaintingStyle.fill;
    //a circle
    // canvas.drawCircle(Offset(200, 200), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}