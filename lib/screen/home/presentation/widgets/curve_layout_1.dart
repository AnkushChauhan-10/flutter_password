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
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bg1.jpg"),
        //   ),
        // ),
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
    path.lineTo(0, h + h * 0.1);
    path.lineTo(w, h + h * 0.1);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
