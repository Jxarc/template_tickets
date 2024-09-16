import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

extension BuildContextExtension on BuildContext {
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Properties
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  AppLocalizations get strings => AppLocalizations.of(this) ?? AppLocalizationsEs();

  /// For default font family from this styles is Nunito Font
  /// ## FontSize
  /// + displayLarge: 57
  /// + displayMedium: 45
  /// + displaySmall: 36
  /// + headlineLarge: 32
  /// + headlineMedium: 28
  /// + headlineSmall: 24
  /// + titleLarge: 20
  /// + titleMedium: 18
  /// + titleSmall: 16
  /// + bodyLarge: 15
  /// + bodyMedium: 14
  /// + bodySmall: 13
  /// + labelLarge: 12
  /// + labelMedium: 11
  /// + labelSmall: 10
  TextTheme get textTheme => Theme.of(this).textTheme;
  CLGTheme get theme => Theme.of(this).clgTheme;

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Public Methods
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  void showSnackbar(
    String text, {
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
  }) {
    if (text.isEmpty) return;
    if (mounted) {
      ScaffoldMessenger.of(this).showSnackBar(CLGSnackbar(
        this,
        text: text,
        textColor: textColor,
        textStyle: textStyle,
        textAction: textAction,
        textActionColor: textActionColor,
        color: color,
        margin: margin,
        prefixIcon: prefixIcon,
        onClick: onClick,
        milliseconds: milliseconds,
        neverClose: neverClose,
      ));
    }
  }

  void showCustomToast(
    String text, {
    Color? textColor,
    TextStyle? textStyle,
    Color? color,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextAlign textAlign = TextAlign.center,
    int milliseconds = 2000,
    Widget? prefixIcon,
    bool shadow = false,
  }) {
    if (text.isEmpty) return;
    if (mounted) {
      ScaffoldMessenger.of(this).showSnackBar(CLGToast(
        this,
        text: text,
        textColor: textColor,
        textStyle: textStyle,
        color: color,
        margin: margin,
        padding: padding,
        textAlign: textAlign,
        milliseconds: milliseconds,
        prefixIcon: prefixIcon,
        shadow: shadow,
      ));
    }
  }

  void hideSnackbar() {
    if (mounted) ScaffoldMessenger.of(this).removeCurrentSnackBar();
  }

  void showToast(
    String text, {
    CLGMessageType type = CLGMessageType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    showCustomToast(
      text,
      shadow: true,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      milliseconds: duration.inMilliseconds,
      textColor: theme.gray.shade400,
      color: theme.white,
      prefixIcon: CLGIcon(
        path: type.icon,
        color: type.getColor(this),
        size: 20,
      ),
    );
  }
}
