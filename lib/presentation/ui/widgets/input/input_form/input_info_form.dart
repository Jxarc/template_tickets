import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGInputInfoForm extends StatelessWidget {
  final Color? helperColor;
  final String? helperText;
  final String? errorText;
  const CLGInputInfoForm({
    super.key,
    this.helperColor,
    this.helperText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    if (helperText == null && errorText == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 6),
      child: CLGText(
        errorText ?? helperText ?? '',
        style: context.textTheme.labelLarge?.copyWith(
          color: isError ? context.theme.magenta : helperColor ?? context.theme.gray.shade400,
        ),
      ),
    );
  }

  bool get isError => errorText != null;
}
