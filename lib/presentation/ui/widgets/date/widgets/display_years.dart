part of '../clg_date.dart';

class _DisplayYears extends StatelessWidget {
  final _DateController controller;
  const _DisplayYears(this.controller);

  @override
  Widget build(BuildContext context) {
    final startYear = controller.firstDate.value.year;
    final endYear = controller.lastDate.value.year;
    final diff = (endYear - startYear) + 1;
    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 15),
      crossAxisCount: 3,
      childAspectRatio: 10 / 4,
      children: List.generate(diff, (index) {
        final year = startYear + index;
        final isActive = controller.containsYear(year);
        return ValueListenableBuilder(
          valueListenable: controller.yearDisplayed,
          builder: (context, value, child) {
            return _Year(
              style: controller.style?.style ?? CLGDateStyleType.line,
              text: year.toString(),
              isActive: isActive,
              textStyle: controller.style?.yearTextStyle,
              textColor: controller.style?.yearTextColor,
              activeColor: controller.style?.activeColor,
              activeTextColor: controller.style?.activeTexColor,
              onClick: () {
                controller.updateYear(year);
                controller.toggleYearMode();
              },
            );
          },
        );
      }),
    );
  }
}
