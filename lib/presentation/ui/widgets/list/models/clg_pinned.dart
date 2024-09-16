import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class CLGPinned {
  final double maxHeight;
  final double minHeight;
  final bool pinned;
  final Color? color;
  final Widget? child;
  final EdgeInsets? padding;

  CLGPinned({
    this.pinned = false,
    required this.maxHeight,
    double minHeight = 0,
    this.child,
    this.color,
    this.padding,
  }) : minHeight = minHeight > 0 ? math.min(maxHeight, minHeight) : maxHeight;
}
