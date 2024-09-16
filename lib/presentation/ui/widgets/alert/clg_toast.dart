import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

class CLGToast extends SnackBar {
  CLGToast(
    BuildContext context, {
    Key? key,
    required String text,
    Color? textColor,
    TextStyle? textStyle,
    Color? color,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextAlign textAlign = TextAlign.center,
    int milliseconds = 2000,
    bool shadow = false,
    Widget? prefixIcon,
  }) : super(
          key: key,
          elevation: 0,
          duration: Duration(milliseconds: milliseconds),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: padding ?? const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 2,
                  bottom: 5,
                  left: 2,
                  right: 2,
                ),
                decoration: BoxDecoration(
                  color: color ?? Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: shadow
                      ? [
                          BoxShadow(
                            color: context.theme.gray.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefixIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: prefixIcon,
                      ),
                    Flexible(
                      child: CLGText(
                        text,
                        textAlign: textAlign,
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
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          margin: margin ?? const EdgeInsets.only(bottom: 25, left: 10, right: 10),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          dismissDirection: DismissDirection.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        );
}
