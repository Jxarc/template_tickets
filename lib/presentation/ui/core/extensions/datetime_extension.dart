extension DateTimeExtension on DateTime {
  int get secondsSinceEpoch {
    return millisecondsSinceEpoch ~/ 1000;
  }

  DateTime get startWeek {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime get endWeek {
    return startWeek.add(const Duration(days: 6));
  }

  DateTime get nextWeek {
    return startWeek.add(const Duration(days: 7));
  }

  DateTime get previusWeek {
    return startWeek.subtract(const Duration(days: 7));
  }

  DateTime get previousMonth {
    return DateTime(year, month - 1, 1);
  }

  DateTime get nextMonth {
    return DateTime(year, month + 1, 1);
  }

  DateTime get lastDayOfMonth {
    return month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
  }

  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get firstDayOfYear {
    return DateTime(year, 1, 1);
  }

  DateTime get lastDayOfYear {
    return DateTime(year + 1, 1, 1).subtract(const Duration(days: 1));
  }

  DateTime get gmt0 {
    var dateTime = this;

    if (dateTime.timeZoneOffset < Duration.zero) {
      dateTime = dateTime.add(dateTime.timeZoneOffset.abs());
    } else {
      dateTime = dateTime.subtract(dateTime.timeZoneOffset.abs());
    }
    return dateTime;
  }

  String get utcOffset {
    final time = DateTime.now().timeZoneOffset;
    final hours = time.inHours.abs().toString().padLeft(2, '0');
    final minutes = time.inMinutes.remainder(60).abs().toString().padLeft(2, '0');
    final isNegative = time.isNegative;

    final result = '${isNegative ? '-' : ''}$hours:$minutes';
    return result;
  }
}
