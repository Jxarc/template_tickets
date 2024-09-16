part of '../clg_date.dart';

class _DisplayMonths extends StatelessWidget {
  final _DateController controller;
  const _DisplayMonths(this.controller);

  @override
  Widget build(BuildContext context) {
    int startYear = 1;
    int endYear = 12;
    final diff = (endYear - startYear) + 1;
    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 15),
      crossAxisCount: 2,
      childAspectRatio: 10 / 4,
      children: List.generate(diff, (index) {
        final month = index + 1;
        final isActive = controller.containsMonth(DateTime(controller.yearDisplayed.value, controller.monthDisplayed.value), month);
        return ValueListenableBuilder(
          valueListenable: controller.monthDisplayed,
          builder: (context, value, child) {
            return _Month(
              style: controller.style?.style ?? CLGDateStyleType.line,
              text: _monthLabel(controller.yearDisplayed.value, month, controller.locale),
              isActive: isActive,
              textStyle: controller.style?.yearTextStyle,
              textColor: controller.style?.yearTextColor,
              activeColor: controller.style?.activeColor,
              activeTextColor: controller.style?.activeTexColor,
              onClick: () {
                controller.updateMonth(month);
                controller.toggleDate(DateTime(controller.yearDisplayed.value, month));
              },
            );
          },
        );
      }),
    );
  }
}
