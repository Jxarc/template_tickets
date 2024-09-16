part of '../clg_date.dart';

enum CLGDateStyleType { line, circleFilled, circleOutline }

class CLGDateStyle {
  final CLGDateStyleType style;
  final CLGDateStyleType todayStyleType;
  final Color? todayColor;

  final TextStyle? monthTextStyle;
  final TextStyle? weekdayTextStyle;
  final TextStyle? yearTextStyle;
  final TextStyle? dayTextStyle;

  final Color? monthTextColor;
  final Color? weekdayTextColor;
  final Color? yearTextColor;
  final Color? dayTextColor;
  final Color? activeTexColor;

  final Color? activeColor;
  final Color? onActiveColor;
  final Color? disabledColor;
  final Color? inactiveMonthDayColor;

  CLGDateStyle({
    this.style = CLGDateStyleType.circleFilled,
    this.todayStyleType = CLGDateStyleType.line,
    this.todayColor,
    this.monthTextStyle,
    this.weekdayTextStyle,
    this.dayTextStyle,
    this.yearTextStyle,
    this.monthTextColor,
    this.weekdayTextColor,
    this.yearTextColor,
    this.dayTextColor,
    this.activeTexColor = Colors.white,
    this.activeColor,
    this.onActiveColor,
    this.disabledColor,
    this.inactiveMonthDayColor,
  });
}
