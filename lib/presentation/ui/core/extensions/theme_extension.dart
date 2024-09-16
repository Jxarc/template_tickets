import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

extension ThemeDataExtension on ThemeData {
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Properties
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  static final Map<String, CLGTheme> _own = {};
  static CLGTheme? empty;

  CLGTheme get clgTheme {
    var own = _own['CLGTheme'];
    if (own == null) {
      empty ??= CLGTheme();
      own = empty;
    }
    return own!;
  }

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Public Methods
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  void applyThemePackage(CLGTheme theme) {
    _own['CLGTheme'] = theme;
  }
}
