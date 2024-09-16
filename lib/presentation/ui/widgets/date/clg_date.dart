import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/presentation/ui/ui.dart';

part 'controller/date_controller.dart';
part 'model/calendar_value.dart';
part 'model/clg_date_style.dart';
part 'model/clg_mark_date.dart';
part 'widgets/day.dart';
part 'widgets/date_mode.dart';
part 'widgets/display_month.dart';
part 'widgets/display_months.dart';
part 'widgets/display_month_days.dart';
part 'widgets/display_weekdays_titles.dart';
part 'widgets/display_years.dart';
part 'widgets/head_selector_year.dart';
part 'widgets/month.dart';
part 'widgets/month_mode.dart';
part 'widgets/selector_month.dart';
part 'widgets/year.dart';
part 'widgets/year_mode.dart';

String _monthLabel(int year, int index, [Locale? locale]) {
  final formatter = DateFormat(DateFormat.MONTH, locale?.languageCode).add_y();
  final month = DateTime(year, index, 1);
  return formatter.format(month).capitalize();
}

bool _isEquals(DateTime date1, DateTime date2) {
  if (date1.year != date2.year) return false;
  if (date1.month != date2.month) return false;
  if (date1.day != date2.day) return false;
  return true;
}

const _height = 324.0;

class CLGDate extends StatelessWidget {
  final CLGDateType type;
  final DateTime initialDate;
  final DateTime lastDate;
  final DateTime? firstDate;

  final TextStyle? textStyle;
  final Color? textColor;
  final Color? activeColor;
  final Color? onActiveColor;
  final CLGDateStyle? style;

  final Locale? locale;

  final ValueChanged<DateTime>? onDateChanged;
  final ValueChanged<List<DateTime>>? onDatesChanged;
  final List<CLGWeekday> inactiveWeekdays;
  final List<CLGMarkDate> markedDates;
  final List<DateTime> enabledDates;
  final List<DateTime> disabledDates;
  final List<DateTime> datesSelected;
  final bool showOnlyRangeDates;
  final bool showTodayIndicator;

  const CLGDate({
    super.key,
    required this.initialDate,
    required this.lastDate,
    this.firstDate,
    @Deprecated(
      'Please remove any reference to it. instead of use [onDatesChanged] for callbacks dates'
      'This feature was deprecated after v0.49.0',
    )
    this.onDateChanged,
    this.datesSelected = const [],
    this.onDatesChanged,
    this.textStyle,
    this.textColor,
    this.activeColor,
    this.onActiveColor,
    this.locale,
    this.inactiveWeekdays = const [],
    this.markedDates = const [],
    this.disabledDates = const [],
    this.enabledDates = const [],
    this.showOnlyRangeDates = false,
    this.showTodayIndicator = false,
    this.type = CLGDateType.single,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final controller = _DateController(
      onDateChanged,
      initialDate,
      lastDate,
      firstDate ?? defaultDate,
      datesSelected,
      type: type,
      locale: locale,
      markedDates: markedDates,
      onDatesChanged: onDatesChanged,
      disabledDates: disabledDates,
      enabledDates: enabledDates,
      inactiveWeekdays: inactiveWeekdays,
      showOnlyRangeDates: showOnlyRangeDates,
      showTodayIndicator: showTodayIndicator,
      style: style,
    );

    return ValueListenableBuilder<bool>(
        valueListenable: controller.monthModeActive,
        builder: (context, value, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !value
                ? _YearMode(controller)
                : controller.type == CLGDateType.month
                    ? _MonthMode(controller)
                    : _DateMode(controller),
          );
        });
  }

  DateTime get defaultDate {
    final startDate = DateTime.now().subtract(const Duration(days: 365 * 80));
    final newDate = DateTime(startDate.year, DateTime.january, 1);
    return newDate;
  }

  static DateTime convertToTimeZone(DateTime date, Duration? timeZoneOffset) {
    final timeZone = timeZoneOffset ?? date.timeZoneOffset;

    if (timeZone.isNegative) {
      final miliseconds = date.millisecondsSinceEpoch - date.timeZoneOffset.abs().inMilliseconds + timeZone.abs().inMilliseconds;
      return DateTime.fromMillisecondsSinceEpoch(miliseconds);
    } else {
      final miliseconds = date.millisecondsSinceEpoch - date.timeZoneOffset.abs().inMilliseconds - timeZone.abs().inMilliseconds;
      return DateTime.fromMillisecondsSinceEpoch(miliseconds);
    }
  }
}
