part of '../clg_date.dart';

class _MonthMode extends StatelessWidget {
  final _DateController controller;

  const _MonthMode(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeadSelectorYear(controller),
        SizedBox(
          height: _height,
          child: _DisplayMonths(controller),
        )
      ],
    );
  }
}
