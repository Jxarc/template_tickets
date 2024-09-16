import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGIcon2 extends Icon {
  const CLGIcon2(
    IconData? icon, {
    Key? key,
    Color? color,
    double? size,
    String? semanticLabel,
    List<Shadow>? shadows,
    TextDirection? textDirection,
  }) : super(
          icon,
          key: key,
          size: size,
          color: color,
          shadows: shadows,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
}

class CLGIcon extends StatelessWidget {
  final String? path;
  final IconData? icon;

  final Color? color;
  final double? size;

  const CLGIcon({
    Key? key,
    this.icon,
    this.path,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Icon(
        icon,
        size: size,
        color: color,
      );
    }

    if (path != null) {
      return CLGImage(
        path: path!,
        height: size,
        width: size,
        color: color,
      );
    }

    throw Exception('CLGIcon required path or icon attribute');
  }
}
