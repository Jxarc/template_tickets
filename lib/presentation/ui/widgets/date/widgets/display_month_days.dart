part of '../clg_date.dart';

class _DisplayMonthDays extends StatefulWidget {
  final _DateController controller;
  final DateTime date;
  const _DisplayMonthDays(
    this.controller, {
    required this.date,
  });

  @override
  State<_DisplayMonthDays> createState() => _DisplayMonthDaysState();
}

class _DisplayMonthDaysState extends State<_DisplayMonthDays> {
  @override
  void initState() {
    widget.controller.datesSelected.addListener(checkDaySelected);
    super.initState();
  }

  checkDaySelected() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final nextMonth = (widget.date.month < 12) ? DateTime(widget.date.year, widget.date.month + 1, 1) : DateTime(widget.date.year + 1, 1, 1);
    final firstDay = DateTime(widget.date.year, widget.date.month, 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1));
    final lastDayPreviusMonth = firstDay.subtract(const Duration(days: 1));

    final startDate = widget.controller.firstDate.value;
    final endDate = widget.controller.lastDate.value;
    final inactiveWeekdays = widget.controller.inactiveWeekdays.map((e) => e.index);
    final showTodayIndicator = widget.controller.showTodayIndicator;

    return Column(
      children: List.generate(
        6,
        (column) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: List.generate(
                7,
                (row) {
                  final position = (column * 7) + row + 1;
                  final value = position - (firstDay.weekday - 1);
                  final currentDate = DateTime(widget.date.year, widget.date.month, value);
                  final isValidDate = currentDate.compareTo(startDate) >= 0 && currentDate.compareTo(endDate) < 0;
                  final isEnabledDay = widget.controller.disabledDates.where((date2) => _isEquals(currentDate, date2)).toList().isEmpty;
                  final markDate = widget.controller.markedDates.where((mark) => _isEquals(currentDate, mark.date)).toList();

                  return ValueListenableBuilder<List<DateTime>>(
                    valueListenable: widget.controller.datesSelected,
                    builder: (context, newValue, child) {
                      var displayValue = value.toString();
                      var isEnable = true;
                      var isDayCurrentMonth = true;
                      var isActive = widget.controller.contains(currentDate) != -1;
                      var todayIndicator = value == DateTime.now().day && DateTime.now().month == widget.date.month && DateTime.now().year == widget.date.year;
                      var backgroundType = _BackgroundType.empty;

                      if (value < 1) {
                        displayValue = '${lastDayPreviusMonth.day - value.abs()}';
                        isDayCurrentMonth = false;
                      }

                      if (value > lastDay.day) {
                        final diff = value - lastDay.day - 1;
                        displayValue = '${nextMonth.day + diff}';
                        isDayCurrentMonth = false;
                      }

                      if (!isValidDate) isEnable = false;
                      if (!isEnabledDay) isEnable = false;
                      if (inactiveWeekdays.contains(row)) isEnable = false;
                      if (widget.controller.enabledDates.isNotEmpty) {
                        isEnable = widget.controller.enabledDates.where((e) => _isEquals(e, currentDate)).isNotEmpty;
                      }

                      if ([
                        CLGDateType.range,
                        CLGDateType.week,
                      ].contains(widget.controller.type)) {
                        final selecteds = widget.controller.datesSelected.value;
                        selecteds.sort();

                        if (selecteds.length == 2) {
                          if (currentDate.compareTo(selecteds.first) == 0) backgroundType = _BackgroundType.rightHalf;
                          if (currentDate.compareTo(selecteds.last) == 0) backgroundType = _BackgroundType.leftHalf;
                          if (currentDate.compareTo(selecteds.first) == 1 && //
                              currentDate.compareTo(selecteds.last) == -1) backgroundType = _BackgroundType.fill;

                          if ((backgroundType == _BackgroundType.rightHalf || backgroundType == _BackgroundType.leftHalf) &&
                              widget.controller.style?.style == CLGDateStyleType.line) backgroundType = _BackgroundType.fill;
                        }
                      }

                      return Expanded(
                        child: _Day(
                          backgroundType: backgroundType,
                          styleType: widget.controller.style?.style,
                          todayStyleType: widget.controller.style?.todayStyleType,
                          todayTextColor: widget.controller.style?.todayColor,
                          onClick: () {
                            widget.controller.toggleDate(currentDate);
                          },
                          markDate: markDate.isNotEmpty ? markDate.first : null,
                          markToday: todayIndicator && showTodayIndicator,
                          text: displayValue,
                          isEnable: isEnable,
                          isDayCurrentMonth: isDayCurrentMonth,
                          isActive: isActive,
                          textStyle: widget.controller.style?.dayTextStyle,
                          textColor: widget.controller.style?.dayTextColor,
                          activeColor: widget.controller.style?.activeColor,
                          onActiveColor: widget.controller.style?.onActiveColor,
                          activeTextColor: widget.controller.style?.activeTexColor,
                          disabledColor: widget.controller.style?.disabledColor,
                          inactiveColor: widget.controller.style?.inactiveMonthDayColor,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
