import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGPopupMenu extends StatelessWidget {
  final List<CLGPopupMenuItem> children;
  final Widget? child;
  final VoidCallback? onOpened;

  const CLGPopupMenu({
    super.key,
    this.child,
    this.children = const [],
    this.onOpened,
  });

  @override
  Widget build(BuildContext context) {
    final items = children.where((e) => e.visible).toList();
    if (items.isEmpty) return const SizedBox();
    return PopupMenuButton(
      onOpened: onOpened,
      tooltip: '',
      elevation: 4,
      color: context.theme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: context.theme.primary.shade300.withOpacity(0.4),
      position: PopupMenuPosition.under,
      offset: const Offset(0, 10),
      itemBuilder: (context) {
        if (items.length == 1) {
          items.firstOrNull?.onClick?.call();
          return [];
        }

        return items
            .map((e) => PopupMenuItem(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: e.size ?? 40,
                  onTap: e.onClick,
                  child: _MenuItem(item: e),
                ))
            .toList();
      },
      child: child,
    );
  }
}

class CLGPopupMenuItem {
  final bool visible;
  final double? size;
  final String label;
  final VoidCallback? onClick;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? iconColor;
  final double? iconSize;
  final TextStyle? textStyle;

  CLGPopupMenuItem({
    this.size,
    this.visible = true,
    this.label = '',
    this.onClick,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.iconSize,
    this.textStyle,
  });
}

class _MenuItem extends StatelessWidget {
  final CLGPopupMenuItem item;
  const _MenuItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = item.iconSize ?? 23;
    final textStyle = item.textStyle ??
        context.textTheme.bodyMedium?.copyWith(
          color: context.theme.gray.shade400,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.prefixIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CLGIcon(
              size: iconSize,
              color: item.iconColor ?? context.theme.primary,
              path: item.prefixIcon,
            ),
          ),
        Expanded(
          child: CLGText(
            item.label,
            style: textStyle,
          ),
        ),
        if (item.suffixIcon != null)
          CLGIcon(
            size: iconSize,
            color: item.iconColor ?? context.theme.primary,
            path: item.suffixIcon,
          ),
      ],
    );
  }
}
