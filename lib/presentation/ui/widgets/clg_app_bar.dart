import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? previusTitle;
  final double? height;
  final Widget? child;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? prefixIcon;

  final Color? color;
  final List<Color>? colors;

  final VoidCallback? onClickBack;
  final double elevation;
  final double borderRadius;

  CLGAppBar({
    super.key,
    required this.title,
    this.previusTitle,
    this.height = 75,
    this.onClickBack,
    this.child,
    this.textColor,
    this.color,
    this.colors,
    this.elevation = 0,
    this.borderRadius = 0,
    this.prefixIcon,
    this.textStyle,
  }) : preferredSize = _PreferredAppBarSize(height, null);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    var colorsGradient = colors;
    if (color == null && colors == null) {
      colorsGradient = [
        context.theme.background,
        context.theme.background,
      ];
    }

    final boxDecoration = BoxDecoration(
      boxShadow: elevation > 0
          ? [
              BoxShadow(
                color: context.theme.shadowColor.withOpacity(0.4),
                blurRadius: elevation,
                offset: const Offset(0, 2),
                spreadRadius: elevation / 10,
              )
            ]
          : null,
      color: color,
      gradient: color == null
          ? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colorsGradient ?? [],
            )
          : null,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ),
    );

    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          decoration: boxDecoration,
          padding: EdgeInsets.only(left: onClickBack != null ? 0 : 20, right: 20),
          child: SafeArea(
            left: orientation == Orientation.portrait,
            right: orientation == Orientation.portrait,
            bottom: false,
            child: SizedBox(
              height: preferredSize.height * 1.09,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: prefixIcon ??
                        _ButtonBack(
                          title,
                          onClick: onClickBack,
                          textColor: textColor,
                          textStyle: textStyle,
                        ),
                  ),
                  if (child != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: child!,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight) : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

class _ButtonBack extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final TextStyle? textStyle;
  final VoidCallback? onClick;

  const _ButtonBack(
    this.text, {
    required this.onClick,
    this.textStyle,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.only(left: onClick != null ? 10 : 0, right: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          foregroundColor: context.theme.shadowColor,
          side: BorderSide.none,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onClick != null)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CLGIcon(
                  path: CLGIcons.angleLeft,
                  color: textColor ?? context.theme.primary.shade600,
                  size: 30,
                ),
              ),
            if (text != null)
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: CLGText(
                    text!,
                    maxLines: 1,
                    style: textStyle?.copyWith(
                          color: textColor ?? context.theme.primary.shade600,
                        ) ??
                        context.textTheme.headlineMedium?.copyWith(
                          color: textColor ?? context.theme.primary.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
