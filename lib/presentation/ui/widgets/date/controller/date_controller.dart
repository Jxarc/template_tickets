part of '../clg_date.dart';

enum CLGWeekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  DateTime get dateCurrentWeek => DateTime.now().startWeek.add(Duration(days: index));

  String getName([Locale? locale]) {
    final formatter = DateFormat('EEEE');
    return formatter.format(dateCurrentWeek);
  }

  String getAbbrevName([Locale? locale]) {
    final formatter = DateFormat('EEE');
    return formatter.format(dateCurrentWeek);
  }

  String get key => switch (this) {
        tuesday => 'mar',
        wednesday => 'mie',
        thursday => 'jue',
        friday => 'vie',
        saturday => 'sab',
        sunday => 'dom',
        _ => 'lun',
      };

  factory CLGWeekday.fromKey(String key) => switch (key) {
        'mar' => tuesday,
        'mie' => wednesday,
        'jue' => thursday,
        'vie' => friday,
        'sab' => saturday,
        'dom' => sunday,
        _ => monday,
      };
}

enum CLGDateType {
  single,
  multi,
  range,
  week,
  month,
}

class _DateController extends _CalendarValue {
  final CLGDateType type;
  final Locale locale;
  final CLGDateStyle? style;
  final ValueChanged<DateTime>? onDateChanged;
  final ValueChanged<List<DateTime>>? onDatesChanged;
  final List<CLGMarkDate> markedDates;
  final List<DateTime> disabledDates;
  final List<DateTime> enabledDates;
  final List<CLGWeekday> inactiveWeekdays;

  final bool showOnlyRangeDates;
  final bool showTodayIndicator;

  int get displayedMonths {
    if (showOnlyRangeDates) {
      if (yearDisplayed.value == firstDate.value.year && yearDisplayed.value == lastDate.value.year) {
        return (lastDate.value.month - firstDate.value.month) + 1;
      }
      if (yearDisplayed.value == lastDate.value.year) {
        return lastDate.value.month;
      } else if (yearDisplayed.value == firstDate.value.year) {
        return (12 - firstDate.value.month) + 1;
      }
    }
    return 12;
  }

  int get startMonth {
    if (showOnlyRangeDates) {
      if (yearDisplayed.value == firstDate.value.year && yearDisplayed.value == lastDate.value.year) {
        return (firstDate.value.month) - 1;
      }

      if (yearDisplayed.value == firstDate.value.year) {
        return (firstDate.value.month) - 1;
      }
    }
    return 0;
  }

  _DateController(
    this.onDateChanged,
    DateTime date,
    DateTime lastDate,
    DateTime firstDate,
    List<DateTime> datesSelected, {
    Locale? locale,
    this.onDatesChanged,
    this.type = CLGDateType.single,
    this.markedDates = const [],
    this.disabledDates = const [],
    this.enabledDates = const [],
    this.inactiveWeekdays = const [],
    this.showOnlyRangeDates = false,
    this.showTodayIndicator = false,
    this.style,
  }) : locale = locale ?? Locale(Platform.localeName.split('_')[0]) {
    super.yearDisplayed.value = date.year;
    super.monthDisplayed.value = date.month;
    super.lastDate.value = lastDate;
    super.firstDate.value = firstDate;

    if (datesSelected.isEmpty) return;
    if (type == CLGDateType.week) {
      super.datesSelected.value = [
        DateUtils.dateOnly(datesSelected.first.startWeek),
        DateUtils.dateOnly(datesSelected.first.endWeek),
      ];
    } else {
      super.datesSelected.value = datesSelected.map((e) => DateUtils.dateOnly(e)).toList();
    }
  }

  void updateYear(int year) {
    if (showOnlyRangeDates) {
      if (year == firstDate.value.year) {
        if (monthDisplayed.value < firstDate.value.month) {
          monthDisplayed.value = firstDate.value.month;
        }
      }

      if (year == lastDate.value.year) {
        if (monthDisplayed.value > lastDate.value.month) {
          monthDisplayed.value = lastDate.value.month;
        }
      }
    }
    yearDisplayed.value = year;
  }

  void updateMonth(int month) {
    if (showOnlyRangeDates) {
      if (month == firstDate.value.month) {
        if (monthDisplayed.value < firstDate.value.month) {
          monthDisplayed.value = firstDate.value.month;
        }
      }

      if (month == lastDate.value.month) {
        if (monthDisplayed.value > lastDate.value.month) {
          monthDisplayed.value = lastDate.value.month;
        }
      }
    }
    monthDisplayed.value = month;
  }

  int get inititalPage {
    if (showOnlyRangeDates) {
      if (displayedMonths != 12) {
        if (yearDisplayed.value == firstDate.value.year && yearDisplayed.value == lastDate.value.year) {
          final diffStartMonths = firstDate.value.month - 1;
          return (monthDisplayed.value - diffStartMonths) - 1;
        }

        if (yearDisplayed.value == firstDate.value.year) {
          final diffStartMonths = firstDate.value.month - 1;
          return (monthDisplayed.value - diffStartMonths) - 1;
        }

        if (yearDisplayed.value == lastDate.value.year) {
          if (monthDisplayed.value > lastDate.value.month) {
            final diffEndMonths = 12 - lastDate.value.month - 1;
            return (monthDisplayed.value - diffEndMonths);
          }
        }
      }
    }

    return monthDisplayed.value - 1;
  }

  toggleYearMode() {
    monthModeActive.value = !monthModeActive.value;
  }

  @override
  toggleDate(DateTime date) {
    switch (type) {
      case CLGDateType.single:
        super.clearDates();
        super.toggleDate(date);

        if (onDateChanged != null) onDateChanged!(date);
        break;
      case CLGDateType.multi:
        super.toggleDate(date);
        break;

      case CLGDateType.week:
        super.clearDates();
        super.toggleDate(DateUtils.dateOnly(date.startWeek));
        super.toggleDate(DateUtils.dateOnly(date.endWeek));
        break;

      case CLGDateType.range:
        if (datesSelected.value.length > 1) {
          super.clearDates();
        }
        super.toggleDate(date);
        break;
      case CLGDateType.month:
        super.clearDates();
        super.toggleDate(date);
        if (onDateChanged != null) onDateChanged!(date);
        break;
    }

    if (onDatesChanged != null) {
      List<DateTime> dates = datesSelected.value;
      if (type == CLGDateType.range) dates.sort();
      onDatesChanged!(dates);
    }
  }
}
