import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGInputCheckForm extends StatelessWidget {
  final String? title;
  final bool checked;
  final Function(bool?) onChanged;
  final String? requiredText;
  final String? errorText;
  final String? helperText;

  const CLGInputCheckForm({
    super.key,
    required this.onChanged,
    this.title,
    this.checked = false,
    this.requiredText,
    this.errorText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: context.theme.primary.shade100,
            highlightColor: context.theme.primary.shade100,
            onTap: () => onChanged(!checked),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CLGCheckbox(
                  value: checked,
                  onChanged: onChanged,
                  shape: BoxShape.rectangle,
                ),
                const SizedBox(width: 10),
                Visibility(
                  visible: title != null,
                  child: Flexible(
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: context.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: requiredText,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.theme.magenta,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
