import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGInputDropdownFormOption {
  final String id;
  final String label;

  CLGInputDropdownFormOption(this.id, this.label);
}

class CLGInputDropdownForm extends StatelessWidget {
  final String? title;
  final String? placeholder;
  final List<CLGInputDropdownFormOption> options;
  final String? selected;
  final EdgeInsets? padding;
  final Function(String?) onChanged;
  final String? requiredText;
  final TextStyle? requiredTextStyle;
  final String? errorText;
  final String? helperText;
  final bool enabled;

  const CLGInputDropdownForm({
    super.key,
    required this.onChanged,
    this.title,
    this.selected,
    this.placeholder,
    this.options = const [],
    this.padding,
    this.requiredText,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.requiredTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CLGInputTitleForm(
            title: title,
            requiredText: requiredText,
            requiredTextStyle: requiredTextStyle,
          ),
          CLGDropdown<String>(
            height: 50,
            onChanged: onChanged,
            initialValue: selected,
            borderColor: errorText != null && errorText!.isNotEmpty ? context.theme.magenta : context.theme.gray.shade200,
            borderWidth: 0.5,
            hintText: placeholder ?? context.strings.select,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.gray.shade400,
            ),
            enable: enabled,
            values: options
                .map(
                  (e) => CLGDropdownItem<String>(
                    value: e.id,
                    label: e.label,
                  ),
                )
                .toList(),
          ),
          CLGInputInfoForm(
            errorText: errorText,
            helperText: helperText,
          ),
        ],
      ),
    );
  }
}
