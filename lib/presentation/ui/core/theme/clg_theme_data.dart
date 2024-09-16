import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGThemeData {
  final CLGTheme packageTheme;
  final TextTheme textTheme;

  static CLGThemeData light() => CLGThemeData.custom(packageTheme: CLGTheme());
  static CLGThemeData dark() => packageDarkTheme;

  static TextScaler textScaleFactorOf(BuildContext context) => MediaQuery.textScalerOf(context).clamp(
        minScaleFactor: 0.9,
        maxScaleFactor: 1.3,
      );

  CLGThemeData.custom({
    required this.packageTheme,
  }) : textTheme = TextTheme(
          displayLarge: CLGFonts.nunito(textStyle: TextStyle(color: packageTheme.textColor)), // default 57
          displayMedium: CLGFonts.nunito(textStyle: TextStyle(color: packageTheme.textColor)), // default 45
          displaySmall: CLGFonts.nunito(textStyle: TextStyle(color: packageTheme.textColor)), // default 36
          headlineLarge: CLGFonts.nunito(textStyle: TextStyle(color: packageTheme.textColor)), // default 32
          headlineMedium: CLGFonts.nunito(textStyle: TextStyle(color: packageTheme.textColor)), // default 28
          headlineSmall: CLGFonts.nunito(textStyle: TextStyle(fontSize: 24, color: packageTheme.textColor)),
          titleLarge: CLGFonts.nunito(textStyle: TextStyle(fontSize: 20, color: packageTheme.textColor)),
          titleMedium: CLGFonts.nunito(textStyle: TextStyle(fontSize: 18, color: packageTheme.textColor)),
          titleSmall: CLGFonts.nunito(textStyle: TextStyle(fontSize: 16, color: packageTheme.textColor)),
          bodyLarge: CLGFonts.nunito(textStyle: TextStyle(fontSize: 15, color: packageTheme.textColor)),
          bodyMedium: CLGFonts.nunito(textStyle: TextStyle(fontSize: 14, color: packageTheme.textColor)),
          bodySmall: CLGFonts.nunito(textStyle: TextStyle(fontSize: 13, color: packageTheme.textColor)),
          labelLarge: CLGFonts.nunito(textStyle: TextStyle(fontSize: 12, color: packageTheme.textColor)),
          labelMedium: CLGFonts.nunito(textStyle: TextStyle(fontSize: 11, color: packageTheme.textColor)),
          labelSmall: CLGFonts.nunito(textStyle: TextStyle(fontSize: 10, color: packageTheme.textColor)),
        );

  ThemeData generate() {
    final theme = (packageTheme.brightness == Brightness.dark) ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);

    return theme.copyWith(
      canvasColor: packageTheme.background,
      brightness: packageTheme.brightness,
      dialogBackgroundColor: packageTheme.dialogBackgroundColor,
      dialogTheme: DialogTheme(
        surfaceTintColor: packageTheme.dialogBackgroundColor,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: packageTheme.dialogBackgroundColor,
        backgroundColor: packageTheme.dialogBackgroundColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: packageTheme.appBarBackgroundColor,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: packageTheme.appBarTextColor,
        ),
        actionsIconTheme: IconThemeData(color: packageTheme.appBarTextColor, size: 10),
        iconTheme: IconThemeData(color: packageTheme.appBarTextColor),
      ),
      cardTheme: CardTheme(
        color: packageTheme.cardColor,
        surfaceTintColor: packageTheme.cardColor,
      ),
      sliderTheme: SliderThemeData(
        thumbColor: packageTheme.secondary,
        activeTrackColor: packageTheme.secondary,
        inactiveTrackColor: packageTheme.disabledColor,
        overlayColor: packageTheme.secondary.shade900,

        //Disable colors
        disabledActiveTickMarkColor: packageTheme.disabledColor,
        disabledActiveTrackColor: packageTheme.disabledColor,
        disabledInactiveTickMarkColor: packageTheme.disabledColor,
        disabledInactiveTrackColor: packageTheme.disabledColor,
        disabledThumbColor: packageTheme.disabledColor,

        trackShape: const RoundedRectSliderTrackShape(),
        trackHeight: 3.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
      ),
      scaffoldBackgroundColor: packageTheme.background,
      shadowColor: packageTheme.shadowColor,
      dividerColor: packageTheme.dividerColor,
      disabledColor: packageTheme.disabledColor,
      textTheme: textTheme,
    )..applyThemePackage(packageTheme);
  }

  CLGThemeData copyWith({
    //General colors for package
    MaterialColor? background,
    MaterialColor? shadowColor,
    Color? errorColor,
    Color? dividerColor,
    Color? disabledColor,

    //Design System - Colors
    Color? white,
    Color? black,
    MaterialColor? primary,
    MaterialColor? secondary,
    MaterialColor? tertiary,
    MaterialColor? gray,
    MaterialColor? blue,
    MaterialColor? lila,
    MaterialColor? green,
    MaterialColor? cream,
    Color? colegiumBlue,
    Color? success,
    Color? danger,
    Color? warning,
    Color? redBallon,
    Color? appBarBackgroundColor,
    Color? appBarTextColor,
  }) {
    return CLGThemeData.custom(
      packageTheme: CLGTheme(
        brightness: packageTheme.brightness,
        background: background ?? packageTheme.background,
        shadowColor: shadowColor ?? packageTheme.shadowColor,
        errorColor: errorColor ?? packageTheme.errorColor,
        dividerColor: dividerColor ?? packageTheme.dividerColor,
        disabledColor: disabledColor ?? packageTheme.disabledColor,
        //
        white: white ?? packageTheme.white,
        black: black ?? packageTheme.black,
        primary: primary ?? packageTheme.primary,
        secondary: secondary ?? packageTheme.secondary,
        tertiary: tertiary ?? packageTheme.tertiary,
        gray: gray ?? packageTheme.gray,
        blue: blue ?? packageTheme.blue,
        lila: lila ?? packageTheme.lila,
        green: green ?? packageTheme.green,
        cream: cream ?? packageTheme.cream,
        colegiumBlue: colegiumBlue ?? packageTheme.colegiumBlue,
        success: success ?? packageTheme.success,
        danger: danger ?? packageTheme.danger,
        warning: warning ?? packageTheme.warning,
        redBallon: redBallon ?? packageTheme.redBallon,
        appBarBackgroundColor: appBarBackgroundColor ?? packageTheme.appBarBackgroundColor,
        appBarTextColor: appBarTextColor ?? packageTheme.appBarTextColor,
      ),
    );
  }
}
