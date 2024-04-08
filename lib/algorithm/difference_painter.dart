import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DifferencePainter extends CustomPainter {
  final List<Offset> differences;
  final ui.Image? imageFile;

  DifferencePainter(this.differences, this.imageFile);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

      if(imageFile != null)
      canvas.drawImage(imageFile!, Offset.zero, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
