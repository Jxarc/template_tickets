import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final List<Color>? colors;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final double elevation;
  final LinearGradient? gradient;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  const CLGCard({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.elevation = 1,
    this.child,
    this.color,
    this.colors,
    this.gradient,
    this.margin,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final radiusCard = BorderRadius.circular(borderRadius ?? 8);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: radiusCard,
        gradient:
            gradient ?? (colors != null && color == null ? LinearGradient(colors: colors!, begin: Alignment.topCenter, end: Alignment.bottomCenter) : null),
        color: color ?? context.theme.cardColor,
        border: Border.all(
          color: borderColor ?? context.theme.background,
          width: borderWidth ?? 0.0,
          style: borderWidth == null ? BorderStyle.none : BorderStyle.solid,
        ),
        boxShadow: elevation == 0
            ? null
            : [
                BoxShadow(
                  color: context.theme.shadowColor.shade200,
                  offset: Offset(0, elevation + 1),
                  blurRadius: 4,
                  spreadRadius: -2,
                )
              ],
      ),
      child: child,
    );
  }
}
