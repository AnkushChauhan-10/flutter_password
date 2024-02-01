import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password/screen/home/presentation/widgets/curve_layout_1.dart';

class SliversAppBar extends StatefulWidget {
  const SliversAppBar({
    super.key,
    required this.profileUrl,
    required this.name,
    this.setState,
  });

  final String profileUrl;
  final String name;
  final Function? setState;

  @override
  State<StatefulWidget> createState() => _SliversAppBar();
}

class _SliversAppBar extends State<SliversAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: false,
      snap: false,
      floating: false,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: CurveLayout1(
        child: _MyAppSpace(
          name: widget.name,
          profileUrl: widget.profileUrl,
        ),
      ),
    );
  }
}

class _MyAppSpace extends StatelessWidget {
  const _MyAppSpace({
    Key? key,
    required this.profileUrl,
    required this.name,
  }) : super(key: key);

  final String profileUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);
        final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Opacity(
          opacity: opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Text(
                    'Welcome Home',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 2.0),
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
