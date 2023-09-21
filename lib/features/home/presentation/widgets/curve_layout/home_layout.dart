import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Layout extends MultiChildRenderObjectWidget {
  Layout({
    Key? key,
    required Widget upperContainer,
    required this.upperRatio,
    required Widget lowerContainer,
    required this.lowerRatio,
  }) : super(
          key: key,
          children: [upperContainer, const Icon(Icons.straight), lowerContainer],
        );

  final double upperRatio;
  final double lowerRatio;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLayout();
  }

  @override
  void updateRenderObject(BuildContext context, RenderLayout renderObject) {
    renderObject
      ..initialUpperRatio = upperRatio
      ..initialLowerRatio = lowerRatio;
  }
}

class LayoutParentData extends ContainerBoxParentData<RenderBox> {}

class RenderLayout extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, LayoutParentData>, RenderBoxContainerDefaultsMixin<RenderBox, LayoutParentData> {
  //===========================================   Initial Ratio ========================================================
  double _initialUpperRatio = 1;
  double _initialLowerRatio = 1;

  double get initialUpperRatio => _initialUpperRatio;

  double get initialLowerRatio => _initialLowerRatio;

  set initialUpperRatio(double value) {
    if (value != initialUpperRatio) {
      _initialUpperRatio = value;
      currentUpperRatio = initialUpperRatio;
    }
  }

  set initialLowerRatio(double value) {
    if (value != _initialLowerRatio) {
      _initialLowerRatio = value;
      currentLowerRatio = initialLowerRatio;
    }
  }

  //============================================ Current Ratio ============================================================
  double _currentUpperRatio = 1;
  double _currentLowerRatio = 1;

  double get currentUpperRatio => _currentUpperRatio;

  double get currentLowerRatio => _currentLowerRatio;

  set currentUpperRatio(double value) {
    if (value != currentUpperRatio) {
      _currentUpperRatio = value;
      markNeedsLayout();
      markNeedsPaint();
    }
  }

  set currentLowerRatio(double value) {
    if (value != currentLowerRatio) {
      _currentLowerRatio = value;
      markNeedsLayout();
      markNeedsPaint();
    }
  }

  //========================================================= Touch Point ==============================================
  Offset _touchStartPoint = const Offset(0, 0), _touchEndPoint = const Offset(0, 0);
  double _inc = 0;

  Offset get touchEndPoint => _touchEndPoint;

  Offset get touchStartPoint => _touchStartPoint;

  set touchStartPoint(Offset value) {
    if (touchStartPoint != value) {
      _touchStartPoint = value;
    }
  }

  set touchEndPoint(Offset value) {
    if (touchEndPoint != value) {
      _touchEndPoint = value;
    }
  }

  void _setInitialLayout() {
    double w = constraints.maxWidth, h = constraints.maxHeight;
    double upperWidth = w, upperHeight = h * (currentUpperRatio / (currentLowerRatio + currentUpperRatio)) - 7.5;
    double lowerWidth = w, lowerHeight = h * (currentLowerRatio / (currentUpperRatio + currentLowerRatio)) - 7.5;

    lowerHeight = _inc > 0 ? lowerHeight + _inc : lowerHeight;

    print("lower $lowerHeight");

    RenderBox? upperChild = firstChild;
    RenderBox? midChild;
    RenderBox? lowerChild = lastChild;

    if (upperChild != null) {
      upperChild.layout(BoxConstraints.expand(height: upperHeight, width: upperWidth), parentUsesSize: true);
      final parentData = upperChild.parentData as LayoutParentData;
      midChild = parentData.nextSibling;
      parentData.offset = const Offset(0, 0);
    }
    if (midChild != null) {
      midChild.layout(BoxConstraints.expand(height: 15, width: lowerWidth), parentUsesSize: true);
      final parentData = midChild.parentData as LayoutParentData;
      parentData.offset = Offset(0, upperChild!.size.height);
    }
    if (lowerChild != null) {
      lowerChild.layout(BoxConstraints.expand(width: lowerWidth, height: lowerHeight), parentUsesSize: true);
      final parentData = lowerChild.parentData as LayoutParentData;
      parentData.offset = Offset(0, upperChild!.size.height + midChild!.size.height);
    }
    size = Size(w, h);
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! LayoutParentData) {
      child.parentData = LayoutParentData();
    }
  }

  @override
  void performLayout() {
    _setInitialLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final upperContainer = firstChild;
    final lowerContainer = lastChild;
    RenderBox? midContainer;
    context.canvas
        .drawRect(Rect.fromPoints(offset, Offset(offset.dx + constraints.maxWidth, offset.dy + constraints.maxHeight)), Paint()..color = Colors.blueAccent);
    if (upperContainer != null) {
      final upperParentData = upperContainer.parentData as LayoutParentData;
      midContainer = upperParentData.nextSibling;
      print("offset $offset");
      print("upper ${upperParentData.offset}");
      Path upperPath = Path()
        ..lineTo(offset.dx + upperParentData.offset.dx, offset.dy + upperParentData.offset.dy)
        ..lineTo(offset.dx + upperParentData.offset.dx, offset.dy + upperParentData.offset.dy + upperContainer.size.height)
        ..lineTo(upperContainer.size.width + offset.dx + upperParentData.offset.dx, upperContainer.size.height + offset.dy + upperParentData.offset.dy)
        ..lineTo(upperContainer.size.width + offset.dx + upperParentData.offset.dx, offset.dy + upperParentData.offset.dy)
        ..lineTo(offset.dx + upperParentData.offset.dx, offset.dy + upperParentData.offset.dy)
        ..close();
      context.canvas.drawPath(upperPath, Paint()..color = Colors.blueAccent);
    }
    if (midContainer != null) {
      final midParentData = midContainer.parentData as LayoutParentData;
      final dy = offset.dy, dx = offset.dx;
      final dx1 = midParentData.offset.dx, dy1 = midParentData.offset.dy;
      final w = midContainer.size.width, h = midContainer.size.height;
      final path = Path();

      final p1 = Offset((dx + dx1) + w * 0.05, dy + dy1);
      final p2 = Offset((dx + dx1), (dy + dy1 + h));
      final p3 = Offset((dx + w + dx1), (dy + dy1 + h));
      final p4 = Offset((dx + dx1 + w) - w * 0.05, (dy + dy1));

      print("Point 1 $p1 \n Point 2 $p2 \n Point 3 $p3 \n Point 4 $p4");

      touchStartPoint = p1;
      touchEndPoint = Offset(p4.dx, p3.dy);

      path
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy)
        ..quadraticBezierTo(p3.dx, p3.dy, p4.dx, p4.dy)
        ..lineTo(p1.dx, p1.dy)
        ..close();

      context.canvas.drawPath(path, Paint()..color = Colors.white);
    }
    if (lowerContainer != null) {
      final lowerParentData = lowerContainer.parentData as LayoutParentData;
      print("Lower ${lowerParentData.offset}\n--------------");
      Path lowerPath = Path()
        ..lineTo(offset.dx + lowerParentData.offset.dx, offset.dy + lowerParentData.offset.dy)
        ..lineTo(offset.dx + lowerParentData.offset.dx, offset.dy + lowerParentData.offset.dy + lowerContainer.size.height)
        ..lineTo(offset.dx + lowerParentData.offset.dx + lowerContainer.size.width, offset.dy + lowerParentData.offset.dy + lowerContainer.size.height)
        ..lineTo(offset.dx + lowerParentData.offset.dx + lowerContainer.size.width, lowerParentData.offset.dy + offset.dy)
        ..lineTo(offset.dx + lowerParentData.offset.dx, offset.dy + lowerParentData.offset.dy)
        ..close();
      context.canvas.drawPath(lowerPath, Paint()..color = Colors.yellow);
    }
    defaultPaint(context, offset);
  }

  @override
  bool hitTestSelf(Offset position) {
    if (position.dx >= touchStartPoint.dx && position.dx <= touchEndPoint.dx && position.dy >= touchStartPoint.dy && position.dy <= touchEndPoint.dy) {
      return true && size.contains(position);
    }
    return false;
  }

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
    if (event is PointerDownEvent) {
      print("true");
      _inc += 100;
      markNeedsLayout();
      markNeedsPaint();
    } else {

    }
  }
}
