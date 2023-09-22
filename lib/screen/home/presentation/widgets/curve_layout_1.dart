import 'package:flutter/material.dart';

class CurveLayout1 extends StatelessWidget {
  const CurveLayout1({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipPath(),
      child: Container(
        color: Colors.white,
        child: child,
      ),
    );
  }
}

class CurveClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var w = size.width, h = size.height;
    final path = Path();
    path.lineTo(0, h * 0.05);
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, h * 0.05);
    path.quadraticBezierTo(w, h * 0.05, w - w * 0.05, 0);
    path.lineTo(w * 0.05, 0);
    path.quadraticBezierTo(w * 0.05, 0, 0, h * 0.05);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
