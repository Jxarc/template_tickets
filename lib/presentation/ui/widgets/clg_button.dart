import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

enum CLGIconAlignment { start, end }

class CLGButton extends StatelessWidget {
  final double? width;
  final double height;
  final Color? color;
  final List<Color>? colors;
  final Color? disabledColor;

  final String? text;
  final Alignment? textAlign;
  final Color? textColor;
  final TextStyle? style;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final double elevation;
  final VoidCallback? onClick;
  final FontWeight fontWeight;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? rippleColor;
  final bool expandContent;

  const CLGButton({
    Key? key,
    required this.onClick,
    this.text,
    this.width,
    this.height = 45,
    this.color,
    this.colors,
    this.disabledColor,
    this.style,
    this.fontWeight = FontWeight.normal,
    this.suffixIcon,
    this.prefixIcon,
    this.borderColor,
    this.borderWidth = 0,
    this.elevation = 1,
    this.expandContent = false,
    this.rippleColor,
    this.textColor,
    this.textAlign,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(10);
    var newWidth = width;
    if (text == null && newWidth == null) {
      newWidth = height;
    }

    var colorsGradient = colors;

    final buttonStyle = ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        disabledBackgroundColor: disabledColor ?? context.theme.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: borderWidth,
            style: borderWidth == 0 ? BorderStyle.none : BorderStyle.solid,
          ),
        ),
        backgroundColor: colorsGradient != null ? Colors.transparent : color ?? context.theme.primary,
        shadowColor: colorsGradient != null ? Colors.transparent : null,
        foregroundColor: rippleColor ?? context.theme.primary,
        elevation: onClick == null ? 0 : elevation,
        animationDuration: const Duration(milliseconds: 500),
        minimumSize: const Size(10, 10),
        alignment: textAlign);

    Widget child = SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onClick,
        style: buttonStyle,
        child: _ItemButton(
          expandContent: expandContent,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          text: text,
          style: style?.copyWith(
                color: onClick != null ? textColor ?? context.theme.buttonTextColor : context.theme.background,
              ) ??
              context.textTheme.bodyMedium?.copyWith(
                color: onClick != null ? textColor ?? context.theme.buttonTextColor : context.theme.background,
              ),
        ),
      ),
    );

    if (colorsGradient != null) {
      return _GradientContent(
        height: height,
        width: width,
        colors: colorsGradient,
        elevation: onClick == null ? 0 : elevation,
        borderRadius: borderRadius,
        child: child,
      );
    }

    return child;
  }
}

class _GradientContent extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double elevation;
  final BorderRadius? borderRadius;
  final List<Color> colors;

  const _GradientContent({
    Key? key,
    required this.colors,
    this.width,
    this.height,
    this.child,
    this.elevation = 1,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          boxShadow: [
            if (elevation != 0)
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: elevation / 2,
                offset: const Offset(0, 1),
              )
          ],
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          )),
      child: child,
    );
  }
}

class _ItemButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool expandContent;

  const _ItemButton({
    this.suffixIcon,
    this.prefixIcon,
    this.text,
    this.style,
    this.expandContent = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (text != null && prefixIcon != null) const SizedBox(width: 10),
        if (prefixIcon != null) prefixIcon!,
        if (text != null && !expandContent)
          _TextButton(
            text: text!,
            style: style,
          ),
        if (text != null && expandContent)
          Expanded(
            child: _TextButton(
              text: text!,
              style: style,
            ),
          ),
        if (suffixIcon != null) suffixIcon!,
        if (text != null && suffixIcon != null) const SizedBox(width: 10),
      ],
    );

    return child;
  }
}

class _TextButton extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const _TextButton({
    this.text = '',
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CLGText(
        text,
        style: style ??
            context.textTheme.bodyMedium?.copyWith(
              color: context.theme.white,
              fontWeight: FontWeight.normal,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
