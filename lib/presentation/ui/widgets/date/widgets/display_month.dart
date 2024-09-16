part of '../clg_date.dart';

class _DisplayMonth extends StatelessWidget {
  final _DateController controller;
  final DateTime date;
  const _DisplayMonth(this.controller, {required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          _DisplayWeekDaysTitles(controller),
          _DisplayMonthDays(controller, date: date),
        ],
      ),
    );
  }
}
