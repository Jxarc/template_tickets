import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGInputRadioForm {
  final int id;
  final String label;

  CLGInputRadioForm(this.id, this.label);
}

class CLGInputRadioGroupForm extends StatelessWidget {
  final String? title;
  final List<CLGInputRadioForm> options;
  final int selected;

  final Function(int?) onChanged;
  final String? requiredText;
  final String? errorText;
  final String? helperText;

  const CLGInputRadioGroupForm({
    super.key,
    required this.onChanged,
    this.title,
    this.selected = 0,
    this.options = const [],
    this.requiredText,
    this.errorText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CLGInputTitleForm(
            title: title,
            requiredText: requiredText,
          ),
          ...options.map(
            (e) => InkWell(
              splashColor: context.theme.primary.shade100,
              highlightColor: context.theme.primary.shade100,
              borderRadius: BorderRadius.circular(20),
              onTap: () => onChanged(e.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    CLGRadio(
                      value: e.id,
                      onChanged: onChanged,
                      groupValue: selected,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: CLGText(
                        e.label,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CLGInputInfoForm(
            errorText: errorText,
            helperText: helperText,
          )
        ],
      ),
    );
  }
}
