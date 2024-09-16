import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGEmptyState extends StatelessWidget {
  final String? imagePath;
  final double imageScale;
  final double imageSpacing;
  final Widget? titlePrefixIcon;
  final String? title;
  final TextStyle? titleStyle;
  final Color? titleColor;

  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Color? subtitleColor;
  final EdgeInsets? padding;

  const CLGEmptyState({
    super.key,
    this.imagePath,
    this.imageScale = 1,
    this.titlePrefixIcon,
    this.title,
    this.titleStyle,
    this.titleColor,
    this.subtitle,
    this.subtitleStyle,
    this.subtitleColor,
    this.padding,
    this.imageSpacing = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null) ...[
              LayoutBuilder(builder: (context, constraints) {
                return CLGImage(
                  path: imagePath!,
                  width: constraints.maxWidth * 0.8 * imageScale,
                );
              }),
              SizedBox(height: imageSpacing),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (titlePrefixIcon != null) ...[
                  titlePrefixIcon!,
                  const SizedBox(width: 5),
                ],
                if (title != null)
                  Flexible(
                    child: CLGText(
                      title!,
                      textAlign: TextAlign.center,
                      style: titleStyle?.copyWith(
                            color: titleColor ?? context.theme.primary,
                          ) ??
                          context.textTheme.titleMedium?.copyWith(
                            color: titleColor ?? context.theme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
              ],
            ),
            if (subtitle != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: CLGText(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: subtitleStyle?.copyWith(
                            color: subtitleColor ?? context.theme.gray.shade400,
                          ) ??
                          context.textTheme.bodyMedium?.copyWith(
                            color: subtitleColor ?? context.theme.gray.shade400,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
