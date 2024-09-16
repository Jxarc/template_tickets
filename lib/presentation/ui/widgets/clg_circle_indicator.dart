import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGCircleIndicator extends StatelessWidget {
  final double size;
  final double elevation;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final String text;

  const CLGCircleIndicator({
    Key? key,
    this.size = 20,
    this.elevation = 0,
    this.color,
    this.textColor,
    this.text = '',
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor,
            blurRadius: elevation,
            spreadRadius: elevation / 3,
          ),
        ],
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: CLGText(
        text,
        textAlign: TextAlign.center,
        style: style?.copyWith(
              color: textColor ?? context.theme.textColor,
            ) ??
            context.textTheme.bodySmall?.copyWith(
              color: textColor ?? context.theme.textColor,
              fontWeight: FontWeight.bold,
              fontSize: size,
            ),
      ),
    );
  }
}
