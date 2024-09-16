import 'dart:io';
import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

part 'widgets/action_dialog.dart';
part 'widgets/content_action_dialog.dart';
part 'widgets/content_dialog.dart';

class CLGActionDialog {
  final String title;
  final Function onClick;

  const CLGActionDialog({
    required this.title,
    required this.onClick,
  });
}

class CLGDialog extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;
  final Widget? header;
  final String? title;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final BorderRadius? borderRadius;

  final String? description;
  final TextStyle? descriptionStyle;
  final Color? descriptionColor;

  final List<CLGActionDialog> actions;
  final EdgeInsets? insetPadding;

  /// The param [sizeContent] receive values from 0.0 to 1.0
  /// that's for control content height
  final double sizeContent;

  const CLGDialog({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.header,
    this.title,
    this.titleColor,
    this.titleStyle,
    this.description,
    this.descriptionColor,
    this.descriptionStyle,
    this.actions = const [],
    this.sizeContent = 1,
    this.insetPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<CLGDialog> createState() => _CLGDialogState();
}

class _CLGDialogState extends State<CLGDialog> {
  double keyboardHeight = 0;

  double get porcentageHeight {
    double value = widget.sizeContent;

    if (value > 1) value = 1;
    if (value < 0) value = 0;

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    //check keyboard
    keyboardHeight = bottom > keyboardHeight ? bottom : keyboardHeight;
    if (bottom < 30) keyboardHeight = bottom;

    var maxHeightActions = 190.0;

    final sizePerAction = maxHeightActions / 5;
    var heightActions = (widget.actions.length + 1) * sizePerAction;

    if (heightActions > maxHeightActions) {
      heightActions = maxHeightActions;
    }

    final heightScreen = (MediaQuery.of(context).size.height - keyboardHeight) * 0.85;
    final maxHeightContent = (heightScreen * porcentageHeight) - heightActions;

    final styleTitle = widget.titleStyle?.copyWith(
          color: widget.titleColor ?? context.theme.textColor,
        ) ??
        context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: widget.titleColor ?? context.theme.textColor,
        );

    return Dialog(
      insetPadding: widget.insetPadding ?? const EdgeInsets.symmetric(horizontal: 35),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: context.theme.dialogBackgroundColor,
      shape: widget.borderRadius != null ? RoundedRectangleBorder(borderRadius: widget.borderRadius!) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.header != null) widget.header!,
          Container(
            padding: EdgeInsets.only(
              top: widget.header != null ? 0 : 20,
              left: 20,
              right: 20,
              bottom: 7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: Platform.isAndroid ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    if (widget.prefixIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: widget.prefixIcon,
                      ),
                    if (widget.title != null)
                      Expanded(
                        child: CLGText(
                          widget.title!,
                          textAlign: Platform.isAndroid ? TextAlign.left : TextAlign.center,
                          style: styleTitle,
                        ),
                      ),
                    if (widget.suffixIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: widget.suffixIcon,
                      )
                  ],
                ),
              ],
            ),
          ),
          _CLGContentDialog(
            maxHeight: maxHeightContent,
            description: widget.description,
            descriptionColor: widget.descriptionColor,
            descriptionStyle: widget.descriptionStyle,
            child: widget.child,
          ),
          if (widget.actions.isNotEmpty)
            _CLGContentActions(
              maxHeight: maxHeightActions,
              actions: widget.actions,
            ),
        ],
      ),
    );
  }
}
