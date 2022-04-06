import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class CleanBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SafeScroll extends StatelessWidget {
  const SafeScroll({Key? key, required this.child, this.direction =Axis.vertical, this.controller}):super(key: key);
  final Axis direction;
  final Widget child;
  final ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior:  CleanBehavior(),
      child: SingleChildScrollView(child: child, scrollDirection: direction, controller: controller, physics: const ClampingScrollPhysics(), ),
    );
  }
}
