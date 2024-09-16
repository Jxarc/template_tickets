import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGAvatar extends StatelessWidget {
  final String? path;
  final String initials;
  final BorderRadiusGeometry? borderRadius;

  final double size;
  final String? placeholder;
  final double elevation;
  final Color statusColor;
  final bool showStatus;

  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;

  final double? borderWidth;
  final Color? borderColor;
  final Widget? overlayIcon;
  final Color? overlayColor;
  final Widget? indicator;
  final Alignment indicatorAlignment;
  final int maxLetters;
  final bool useS3;

  const CLGAvatar({
    super.key,
    this.size = 50,
    this.elevation = 3,
    this.maxLetters = 2,
    this.statusColor = Colors.green,
    this.showStatus = false,
    this.borderColor,
    this.borderWidth,
    this.overlayColor,
    this.overlayIcon,
    this.placeholder,
    this.indicator,
    this.indicatorAlignment = Alignment.bottomRight,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.initials = '',
    this.path,
    this.borderRadius,
    this.useS3 = false,
  });

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
      border: (borderWidth ?? 0) > 0
          ? Border.all(
              width: borderWidth!,
              color: borderColor ?? context.theme.primary,
            )
          : null,
    );

    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          margin: indicator != null ? const EdgeInsets.only(bottom: 2, left: 6, right: 6, top: 2) : EdgeInsets.zero,
          decoration: boxDecoration.copyWith(
            boxShadow: elevation > 0
                ? [
                    BoxShadow(
                      color: context.theme.shadowColor.shade400.withOpacity(0.4),
                      blurRadius: 5,
                      spreadRadius: -5 + elevation,
                      offset: const Offset(0, 5),
                    )
                  ]
                : null,
            color: backgroundColor ?? context.theme.avatarPrimaryColor,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isAlias) _alias(context),
              if (!isAlias)
                ClipRRect(
                  borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
                  child: CLGImage(
                    path: path ?? CLGIcons.image,
                    height: size,
                    width: size,
                    placeholder: Center(child: _alias(context)),
                    fit: BoxFit.cover,
                    useS3: path != null ? useS3 : false,
                  ),
                ),
              AnimatedContainer(
                  width: size,
                  height: size,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: overlayColor,
                  ),
                  child: overlayIcon),
              if (showStatus)
                Positioned(
                    top: size * 0.04,
                    right: size * 0.04,
                    child: CLGCircleIndicator(
                      color: statusColor,
                      size: size / 5,
                    )),
            ],
          ),
        ),
        if (indicator != null)
          Positioned.fill(
            child: Align(
              alignment: indicatorAlignment,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      indicator!,
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String get alias => CLGUtils.getAliasFromName(value, maxLetters);

  String get value => path != null && path!.isNotEmpty ? path! : initials;

  bool get isAlias {
    if ((path ?? '').isEmpty && initials.isNotEmpty) return true;
    if (validUrl(value)) return false;
    if (validBase64(value)) return false;
    if (validAsset(value)) return false;
    if (validFile(value)) return false;

    return true;
  }

  bool validUrl(String text) {
    final regex = RegExp('^https?://.*');
    return useS3 || regex.hasMatch(text);
  }

  bool validBase64(String text) {
    final regex = RegExp('^data:image/.*;base64,.*');
    return regex.hasMatch(text);
  }

  bool validAsset(String text) {
    final regex = RegExp('^(packages/.+/)?assets?/.*');
    return regex.hasMatch(text);
  }

  bool validFile(String text) {
    return text.startsWith('/');
  }

  Widget _alias(BuildContext context) {
    return CLGText(
      CLGUtils.getAliasFromName(initials.isEmpty ? path ?? '' : initials, maxLetters),
      style: textStyle?.copyWith(
            color: textColor ?? context.theme.avatarOnPrimaryColor,
          ) ??
          context.textTheme.titleMedium?.copyWith(
            color: textColor ?? context.theme.avatarOnPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
          ),
    );
  }
}
