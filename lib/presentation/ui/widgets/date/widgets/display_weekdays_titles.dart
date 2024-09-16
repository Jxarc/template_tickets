part of '../clg_date.dart';

class _DisplayWeekDaysTitles extends StatelessWidget {
  final _DateController controller;

  const _DisplayWeekDaysTitles(this.controller);

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final startFrom = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final formatter = DateFormat(DateFormat.ABBR_WEEKDAY, controller.locale.languageCode);
    final days = List.generate(
      DateTime.daysPerWeek,
      (index) => startFrom.add(Duration(days: index)),
    ).map((e) => formatter.format(e).capitalize().replaceFirst('.', '')).toList();

    return Row(
      children: List.generate(
        days.length,
        (index) => Expanded(
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.center,
            child: CLGText(
              days[index],
              style: controller.style?.weekdayTextStyle?.copyWith(
                    color: controller.style?.weekdayTextColor ?? context.theme.calendarActiveColor,
                  ) ??
                  context.textTheme.bodySmall?.copyWith(
                    color: controller.style?.weekdayTextColor ?? context.theme.calendarActiveColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
