part of '../clg_date.dart';

class _HeadSelectorYear extends StatelessWidget {
  final _DateController controller;
  const _HeadSelectorYear(this.controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.toggleYearMode(),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: CLGText(
                    _monthLabel(controller.yearDisplayed.value, controller.monthDisplayed.value, controller.locale),
                    textAlign: TextAlign.center,
                    style: controller.style?.monthTextStyle?.copyWith(
                          color: controller.style?.monthTextColor ?? context.theme.calendarTextColor,
                        ) ??
                        context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.style?.monthTextColor ?? context.theme.calendarTextColor,
                        ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.toggleYearMode(),
                icon: const CLGIcon(
                  path: CLGIcons.angleLeft,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
