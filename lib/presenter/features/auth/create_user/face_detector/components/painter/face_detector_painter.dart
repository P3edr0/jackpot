import 'package:flutter/material.dart';

class FaceDetectorClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double ovalWidth = size.width * 0.7;
    final double ovalHeight = size.height * 0.6;
    final double ovalX = (size.width - ovalWidth) / 2;
    final double ovalY = (size.height - ovalHeight) / 2;
    return Path()
      ..addOval(Rect.fromLTWH(ovalX, ovalY, ovalWidth, ovalHeight))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
