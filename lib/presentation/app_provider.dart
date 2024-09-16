import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class AppProvider extends CLGProvider {
  AppProvider() {
    _init();
  }

  CLGThemeData _theme = CLGThemeData.light();
  CLGThemeData get theme => _theme;
  set theme(CLGThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  static AppProvider init() => Injector.appInstance.get<AppProvider>();
  static AppProvider watch(BuildContext context) => context.watch<AppProvider>();
  static AppProvider read(BuildContext context) => context.read<AppProvider>();

  void _init() {
    _initTheme();
  }

  void _initTheme() {
    theme = CLGThemeData.light().copyWith(
      appBarBackgroundColor: theme.packageTheme.green.shade500,
      appBarTextColor: theme.packageTheme.white,
      background: MaterialColor(
        theme.packageTheme.green.shade100.value,
        {
          100: theme.packageTheme.background.shade100,
          200: theme.packageTheme.background.shade200,
          300: theme.packageTheme.background.shade300,
          400: theme.packageTheme.background.shade400,
          500: theme.packageTheme.background.shade500,
          600: theme.packageTheme.green.shade100,
          700: theme.packageTheme.background.shade700,
          800: theme.packageTheme.background.shade700,
          900: theme.packageTheme.background.shade700,
        },
      ),
      primary: MaterialColor(
        theme.packageTheme.green.shade500.value,
        {
          100: theme.packageTheme.green.shade100,
          200: theme.packageTheme.green.shade200,
          300: theme.packageTheme.green.shade300,
          400: theme.packageTheme.green.shade400,
          500: theme.packageTheme.green.shade500,
          600: theme.packageTheme.green.shade600,
          700: theme.packageTheme.green.shade700,
          800: theme.packageTheme.green.shade700,
          900: theme.packageTheme.green.shade700,
        },
      ),
    );
  }
}
