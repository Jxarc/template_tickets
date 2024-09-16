import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CLGInputTextForm extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? placeholder;
  final String? errorText;
  final String? helperText;
  final TextEditingController controller;
  final CLGInputType type;
  final EdgeInsets? padding;
  final String? requiredText;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundDisabledColor;
  final TextAlign? textAlign;

  const CLGInputTextForm({
    super.key,
    required this.controller,
    this.title,
    this.titleColor,
    this.placeholder,
    this.errorText,
    this.helperText,
    this.type = CLGInputType.alphanumeric,
    this.padding,
    this.requiredText,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.inputFormatters,
    this.textColor,
    this.borderColor,
    this.backgroundDisabledColor,
    this.textAlign,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [
      if (type == CLGInputType.email) FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ...(this.inputFormatters ?? []),
    ];
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CLGInputTitleForm(
            title: title,
            titleColor: titleColor,
            requiredText: requiredText,
          ),
          CLGTextField(
            inputFormatters: inputFormatters.isNotEmpty ? inputFormatters : null,
            padding: const EdgeInsets.all(15),
            type: type,
            maxLength: maxLength,
            textAlign: textAlign,
            controller: controller,
            textColor: textColor,
            borderColor: borderColor ?? context.theme.shadowColor.shade200,
            borderRadius: BorderRadius.circular(5),
            borderWidth: 0.5,
            hintText: placeholder,
            helperText: helperText,
            helperStyle: context.textTheme.labelLarge?.copyWith(
              color: context.theme.gray.shade400,
            ),
            errorText: errorText,
            errorColor: context.theme.magenta,
            errorStyle: context.textTheme.labelLarge,
            validate: type == CLGInputType.email,
            maxLines: maxLines,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enable: enabled,
            backgroundDisabledColor: backgroundDisabledColor ?? context.theme.shadowColor.shade100.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
