import 'package:flutter/material.dart';

class AccountCardPainter extends CustomPainter {
  AccountCardPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: "testAccount",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    final textAddressPainter = TextPainter(
      text: TextSpan(
        text: "0x14l1k4jlkvjasf987asdahddk2e2987yakjfasfa",
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    final textBalancePainter = TextPainter(
      text: TextSpan(
        text: "2205.10",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    _drawBackgroundRect(canvas, Colors.brown[500]!,
        Rect.fromLTRB(5, 0, size.width * 0.93, size.height - 5));

    _drawBackgroundRect(canvas, Colors.brown[300]!,
        Rect.fromLTRB(0, 10, size.width * 0.9, size.height));

    _drawLock(
      canvas,
      Colors.brown[400]!,
      Rect.fromLTRB(size.width * 0.72, size.height * 0.35, size.width * 0.94,
          size.height * 0.65),
    );

    _drawCustomCircle(
      canvas,
      Colors.orange[300]!,
      Rect.fromLTRB(0, 0, size.width, size.height),
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textAddressPainter.layout(minWidth: 0, maxWidth: size.width * 0.65);
    textBalancePainter.layout(minWidth: 0, maxWidth: size.width);

    final xOffset = size.width * 0.07;
    final yOffset = size.height * 0.1;
    final offset = Offset(xOffset, yOffset);

    textPainter.paint(canvas, offset);
    textAddressPainter.paint(
        canvas, Offset(size.width * 0.07, size.height * 0.25));
    textBalancePainter.paint(
        canvas, Offset(size.width * 0.07, size.height * 0.75));
  }

  void _drawBackgroundRect(Canvas canvas, Color color, Rect shapeBounds) {
    Paint paint = Paint()..color = color;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          shapeBounds,
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
        paint);
  }

  void _drawForegroundRect(Canvas canvas, Color color, Rect shapeBounds) {
    Paint paint = Paint()..color = color;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          shapeBounds,
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        paint);
  }

  void _drawLock(Canvas canvas, Color color, Rect shapeBounds) {
    Paint paint = Paint()..color = color;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          shapeBounds,
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        paint);
  }

  void _drawCustomCircle(Canvas canvas, Color color, Rect shapeBounds) {
    Paint paint = Paint()..color = color;

    Offset center = Offset(shapeBounds.width * 0.82, shapeBounds.height * 0.5);

    canvas.drawCircle(center, 10, paint);
  }

  @override
  bool shouldRepaint(AccountCardPainter oldDelegate) {
    return false;
  }
}
