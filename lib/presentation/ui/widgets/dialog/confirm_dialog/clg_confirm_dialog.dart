import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

export 'clg_confirm_args.dart';

enum CLGMessageType {
  warning,
  info,
  error,
  success,
  delete;

  String get icon => switch (this) {
        CLGMessageType.info => CLGIcons.fillAlertCircle,
        CLGMessageType.warning => CLGIcons.fillAlertCircle,
        CLGMessageType.error => CLGIcons.alertTriangle,
        CLGMessageType.success => CLGIcons.fillCheckmarkCircle,
        CLGMessageType.delete => CLGIcons.trashAlt,
      };

  Color getColor(BuildContext context) => switch (this) {
        CLGMessageType.info => context.theme.primary.shade600,
        CLGMessageType.warning => context.theme.warning,
        CLGMessageType.error => context.theme.danger,
        CLGMessageType.success => context.theme.tertiary,
        CLGMessageType.delete => context.theme.danger,
      };
}

extension CLGMessageTypeExtension on CLGMessageType {
  Color getColorPositiveButton(BuildContext context) {
    switch (this) {
      case CLGMessageType.info:
        return context.theme.primary.shade600;
      case CLGMessageType.warning:
        return context.theme.warning;
      case CLGMessageType.error:
      case CLGMessageType.delete:
        return context.theme.danger;
      case CLGMessageType.success:
        return context.theme.tertiary;
    }
  }

  Color getTextButtonColor(BuildContext context) {
    switch (this) {
      case CLGMessageType.info:
      case CLGMessageType.error:
      case CLGMessageType.delete:
        return context.theme.white;
      case CLGMessageType.warning:
        return context.theme.gray.shade400;
      case CLGMessageType.success:
        return context.theme.black;
    }
  }

  Widget getIcon(BuildContext context) {
    return CLGIcon(
      path: icon,
      color: getColor(context),
      size: 25,
    );
  }
}

class CLGConfirmDialog extends StatelessWidget {
  final CLGMessageType type;
  final String title;
  final String? description;
  final String descriptionBold;
  final String? textPositiveButton;
  final String? textNegativeButton;
  final Function? onPositiveButton;
  final Function? onNegativeButton;
  final Widget? child;
  final bool showIcon;

  const CLGConfirmDialog({
    super.key,
    required this.title,
    this.description,
    this.descriptionBold = '',
    this.textPositiveButton,
    this.textNegativeButton,
    this.onPositiveButton,
    this.onNegativeButton,
    this.type = CLGMessageType.info,
    this.showIcon = true,
    this.child,
  });

  CLGConfirmDialog.fromArgs({
    super.key,
    required CLGConfirmArgs args,
  })  : type = args.type,
        title = args.title,
        description = args.description,
        descriptionBold = args.descriptionBold,
        textPositiveButton = args.textPositiveButton,
        textNegativeButton = args.textNegativeButton,
        onPositiveButton = args.onPositiveButton,
        onNegativeButton = args.onNegativeButton,
        showIcon = args.showIcon,
        child = args.child;

  @override
  Widget build(BuildContext context) {
    return CLGDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      borderRadius: BorderRadius.circular(12),
      header: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: context.textTheme.titleSmall?.copyWith(
              color: context.theme.gray.shade400,
              fontWeight: FontWeight.bold,
            ),
            children: [
              WidgetSpan(
                child: Visibility(
                  visible: showIcon,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: type.getIcon(context),
                  ),
                ),
              ),
              TextSpan(
                text: title,
              ),
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Visibility(
              visible: description != null,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(color: context.theme.gray.shade400),
                  children: _generateDescriptions(context),
                ),
              ),
            ),
            Visibility(
              visible: descriptionBold.isNotEmpty,
              child: CLGText(
                descriptionBold,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.gray.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child ?? const SizedBox(),
            const SizedBox(height: 10),
            Visibility(
              visible: onNegativeButton != null || onPositiveButton != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Visibility(
                      visible: onNegativeButton != null,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CLGButton(
                            height: 45,
                            elevation: 0,
                            color: context.theme.primary.shade100,
                            textColor: context.theme.primary.shade600,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            text: textNegativeButton ?? context.strings.cancel,
                            onClick: () => onNegativeButton?.call(),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: onPositiveButton != null,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: CLGButton(
                            height: 45,
                            elevation: 0,
                            color: type.getColorPositiveButton(context),
                            textColor: type.getTextButtonColor(context),
                            text: textPositiveButton ?? context.strings.accept,
                            expandContent: true,
                            onClick: () => onPositiveButton?.call(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _generateDescriptions(BuildContext context) {
    if (description == null) return [];
    if (description?.contains('~') == false) return [TextSpan(text: description ?? '')];

    final textBuffer = StringBuffer();
    final normalStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.theme.gray.shade400,
    );

    bool isBold = false;
    List<TextSpan> descriptions = [];

    addDescription() {
      descriptions.add(TextSpan(
        text: textBuffer.toString(),
        style: normalStyle?.copyWith(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }

    for (String i in description?.characters ?? []) {
      if (i == '~') {
        addDescription();
        isBold = !isBold;
        textBuffer.clear();
        continue;
      }

      textBuffer.write(i);
    }

    addDescription();
    return descriptions;
  }
}
