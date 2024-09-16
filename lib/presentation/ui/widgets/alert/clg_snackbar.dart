import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

class CLGSnackbar extends SnackBar {
  CLGSnackbar(
    BuildContext context, {
    Key? key,
    required String text,
    Color? textColor,
    TextStyle? textStyle,
    String? textAction,
    Color? textActionColor,
    Color? color,
    EdgeInsets? margin,
    Widget? prefixIcon,
    Function? onClick,
    int milliseconds = 4000,
    bool neverClose = false,
  }) : super(
          key: key,
          elevation: 5,
          duration: !neverClose ? Duration(milliseconds: milliseconds) : const Duration(days: 1),
          content: Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: prefixIcon,
                ),
              Flexible(
                child: CLGText(
                  text,
                  style: textStyle?.copyWith(
                        color: textColor ?? Colors.white,
                      ) ??
                      context.textTheme.bodyMedium?.copyWith(
                        color: textColor ?? Colors.white,
                      ),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          margin: margin ?? const EdgeInsets.all(15),
          backgroundColor: color ?? Colors.blue,
          dismissDirection: !neverClose ? DismissDirection.horizontal : DismissDirection.none,
          action: textAction != null
              ? SnackBarAction(
                  onPressed: () {
                    if (onClick != null) onClick();
                  },
                  label: textAction,
                  textColor: textActionColor ?? Colors.white,
                )
              : null,
        );
}
