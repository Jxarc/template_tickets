import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGProgressDialog extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? color;
  final double size;
  final double strokeWidth;
  final Axis direction;
  final EdgeInsets? insetPadding;

  const CLGProgressDialog(
    this.text, {
    super.key,
    this.textColor,
    this.textStyle,
    this.color,
    this.size = 50,
    this.strokeWidth = 5,
    this.direction = Axis.vertical,
    this.insetPadding,
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget = CLGText(
      text,
      textAlign: TextAlign.center,
      style: textStyle?.copyWith(
            color: textColor ?? context.theme.textColor,
          ) ??
          context.textTheme.bodyMedium?.copyWith(
            color: textColor ?? context.theme.textColor,
          ),
    );

    if (direction == Axis.horizontal) textWidget = Flexible(child: textWidget);

    final children = [
      SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color ?? context.theme.primary.shade500,
          backgroundColor: context.theme.disabledColor,
        ),
      ),
      const SizedBox(height: 20, width: 20),
      textWidget,
    ];
    return CLGDialog(
      insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: direction == Axis.horizontal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
      ),
    );
  }
}
