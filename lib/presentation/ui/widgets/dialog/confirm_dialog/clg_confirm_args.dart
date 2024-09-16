import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/widgets.dart';

class CLGConfirmArgs {
  final CLGMessageType type;
  final String title;
  final String? description;
  final String descriptionBold;
  final String? textPositiveButton;
  final String? textNegativeButton;
  final Function? onPositiveButton;
  final Function? onNegativeButton;
  final bool showIcon;
  final bool barrierDismissible;
  final Widget? child;

  const CLGConfirmArgs({
    required this.title,
    this.description,
    this.descriptionBold = '',
    this.textPositiveButton,
    this.textNegativeButton,
    this.onPositiveButton,
    this.onNegativeButton,
    this.type = CLGMessageType.info,
    this.showIcon = true,
    this.barrierDismissible = true,
    this.child,
  });
}
