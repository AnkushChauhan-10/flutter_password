import 'package:flutter/material.dart';

class LayoutAnimation extends AnimatedWidget {
  LayoutAnimation({
    super.key,
    required Animation<double> animation,
    required this.child,
    required this.width,
    required this.height,
  }) : super(listenable: animation);

  Widget child;
  double width, height;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Positioned(
      left: 0,
      bottom: 0,
      height: height*animation.value,
      width: width,
      child: child,
    );
  }
}
