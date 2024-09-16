import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGClick extends StatelessWidget {
  final Color? backgroundColor;
  final Color? rippleColor;
  final Widget? child;
  final VoidCallback? onClick;
  final VoidCallback? onLongPress;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  const CLGClick({
    super.key,
    this.backgroundColor,
    this.padding,
    this.rippleColor,
    this.onClick,
    this.borderRadius,
    this.onLongPress,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: backgroundColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onLongPress: onLongPress,
        splashColor: rippleColor ?? context.theme.primary.shade900.withOpacity(0.1),
        highlightColor: rippleColor ?? context.theme.primary.shade900.withOpacity(0.1),
        onTap: onClick,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
