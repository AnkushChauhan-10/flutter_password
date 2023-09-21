import 'package:flutter/material.dart';

class CurveLayout extends StatelessWidget {
  const CurveLayout({
    super.key,
    this.dragUp,
    this.dragDown,
    this.child,
  });

  final Widget? child;
  final Function()? dragUp;
  final Function()? dragDown;

  @override
  Widget build(BuildContext context) {
    double initial = 0;
    double end = 0;
    return ClipPath(
      clipper: CurveClipPath(),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onVerticalDragStart: (details) {
                initial = details.localPosition.dy;
              },
              onVerticalDragEnd: (details) {
                if (initial > end) {
                  dragUp?.call();
                } else if (end > initial) {
                  dragDown?.call();
                }
                print("Start = $initial, end = $end");
              },
              onVerticalDragUpdate: (details) {
                end = details.localPosition.dy;
              },
              child: Container(
                width: double.infinity,
                color: Colors.white60,
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Icon(Icons.linear_scale),
              ),
            ),
            Expanded(
              child: Center(
                child: child ?? Text("Empty"),
              ),
            ),
          ],
        ),
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
