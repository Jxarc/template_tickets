import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

class CLGImageButton extends StatelessWidget {
  final double size;

  final Color? color;
  final List<Color>? colors;
  final Color? suffixIconColor;

  final Widget? icon;
  final Widget? suffixIcon;

  final double elevation;
  final VoidCallback? onClick;

  final double borderWidth;
  final Color? borderColor;
  final double? borderRadius;

  const CLGImageButton({
    super.key,
    required this.icon,
    required this.onClick,
    this.size = 30,
    this.color,
    this.colors,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.suffixIcon,
    this.suffixIconColor,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius == null ? (size * 100) : borderRadius!);

    var colorsGradient = colors;
    if (color == null && colors == null) {
      colorsGradient = [context.theme.primary, context.theme.primary.shade900];
    }

    Widget child = SizedBox(
      height: size,
      width: size,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(size, size),
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(
              color: borderColor ?? context.theme.primary,
              width: borderWidth,
              style: borderWidth == 0 ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
          backgroundColor: colorsGradient != null ? Colors.transparent : color ?? Theme.of(context).scaffoldBackgroundColor,
          shadowColor: colorsGradient != null ? Colors.transparent : null,
          elevation: elevation,
          foregroundColor: colorsGradient != null ? Colors.transparent : color?.withOpacity(0.7) ?? Theme.of(context).scaffoldBackgroundColor,
          animationDuration: const Duration(milliseconds: 500),
        ),
        child: icon,
      ),
    );

    if (colorsGradient != null) {
      child = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
            blurRadius: elevation / 2,
            offset: const Offset(0, 1),
          ) //blur radius of shadow
        ], borderRadius: radius, gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: colorsGradient)),
        child: child,
      );
    }

    if (suffixIcon != null) {
      child = Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: child,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CLGImageButton(
              color: suffixIconColor ?? context.theme.primary.shade200,
              size: size * 0.42,
              icon: suffixIcon,
              onClick: () {},
            ),
          ),
        ],
      );
    }

    return child;
  }
}
