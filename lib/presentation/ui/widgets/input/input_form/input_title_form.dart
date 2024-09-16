import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGInputTitleForm extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? requiredText;
  final TextStyle? requiredTextStyle;
  const CLGInputTitleForm({
    super.key,
    this.title,
    this.titleColor,
    this.requiredText,
    this.requiredTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: context.textTheme.bodyMedium?.copyWith(
                color: titleColor ?? context.theme.gray.shade400,
              ),
            ),
            TextSpan(
              text: requiredText,
              style: requiredTextStyle ??
                  context.textTheme.bodyLarge?.copyWith(
                    color: context.theme.gray,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
