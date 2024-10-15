import 'package:flutter/material.dart';

class BottomCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from the top left
    path.lineTo(0.0, 0.0);

    // Move to the top-right corner
    path.lineTo(size.width, 0.0);

    // Move to the bottom-right and start drawing the cut-out
    path.lineTo(size.width, size.height/3);
    path.quadraticBezierTo(
      size.width / 2, size.height + 30,  // Control point and curve depth
      0.0, size.height - 30,             // End at the bottom-left corner
    );

    path.close(); // Complete the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true
  ;
}