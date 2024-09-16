part of '../clg_date.dart';

enum _BackgroundType {
  empty,
  leftHalf,
  rightHalf,
  fill,
}

class _Day extends StatelessWidget {
  final CLGDateStyleType? styleType;
  final CLGDateStyleType? todayStyleType;
  final Color? todayTextColor;
  final _BackgroundType backgroundType;
  final Function onClick;
  final String text;
  final bool isActive;
  final bool markToday;
  final bool isEnable;
  final bool isDayCurrentMonth;
  final CLGMarkDate? markDate;

  final TextStyle? textStyle;
  final Color? inactiveColor;
  final Color? disabledColor;

  final Color? activeTextColor;
  final Color? activeColor;
  final Color? onActiveColor;
  final Color? textColor;

  const _Day({
    required this.isActive,
    required this.markToday,
    required this.isDayCurrentMonth,
    required this.isEnable,
    required this.onClick,
    required this.text,
    this.styleType,
    this.todayStyleType,
    this.todayTextColor,
    this.markDate,
    this.textStyle,
    this.textColor,
    this.activeTextColor,
    this.activeColor,
    this.onActiveColor,
    this.inactiveColor,
    this.disabledColor,
    this.backgroundType = _BackgroundType.empty,
  });

  @override
  Widget build(BuildContext context) {
    final applyTodayStyle = !isActive && markToday;
    final activeStyle = styleType ?? CLGDateStyleType.line;
    final todayStyle = todayStyleType ?? CLGDateStyleType.line;
    final style = !applyTodayStyle ? activeStyle : todayStyle;

    Color newTextColor = textColor ?? context.theme.calendarTextColor;
    Color newActiveColor = activeColor ?? context.theme.calendarActiveColor;

    if (isActive) newTextColor = activeTextColor ?? context.theme.calendarActiveTextColor;
    if (!isEnable) newTextColor = disabledColor ?? context.theme.calendarDisabledColor.withOpacity(0.75);
    if (!isDayCurrentMonth) newTextColor = inactiveColor ?? context.theme.calendarDisabledColor.withOpacity(0.3);

    if (applyTodayStyle && style == CLGDateStyleType.circleOutline) newTextColor = activeColor ?? context.theme.calendarActiveColor;
    if (applyTodayStyle && style == CLGDateStyleType.circleFilled) newTextColor = todayTextColor ?? newActiveColor;

    final backgroundColor = (isActive || markToday) && style != CLGDateStyleType.line ? newActiveColor : null;
    final isCircle = style == CLGDateStyleType.circleFilled || style == CLGDateStyleType.circleOutline;

    if (isDayCurrentMonth && backgroundType != _BackgroundType.empty) newTextColor = onActiveColor ?? context.theme.calendarOnActiveColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnable && isDayCurrentMonth ? () => onClick() : null,
        child: Container(
          alignment: Alignment.center,
          height: 36,
          child: Stack(
            children: [
              if (isDayCurrentMonth && backgroundType != _BackgroundType.empty)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: newActiveColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(backgroundType == _BackgroundType.rightHalf ? 100 : 0),
                        bottomLeft: Radius.circular(backgroundType == _BackgroundType.rightHalf ? 100 : 0),
                        topRight: Radius.circular(backgroundType == _BackgroundType.leftHalf ? 100 : 0),
                        bottomRight: Radius.circular(backgroundType == _BackgroundType.leftHalf ? 100 : 0),
                      ),
                    ),
                  ),
                ),
              if (isDayCurrentMonth)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: style == CLGDateStyleType.circleFilled ? backgroundColor : null,
                      borderRadius: BorderRadius.circular(isCircle ? 100 : 0),
                      border: backgroundColor != null
                          ? Border.all(
                              color: backgroundColor,
                              width: 1,
                            )
                          : null,
                    ),
                  ),
                ),
              if (markDate != null && isDayCurrentMonth)
                Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 6,
                    width: 6,
                    child: CLGCircleIndicator(
                      color: markDate!.color,
                      elevation: 2,
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: EdgeInsets.zero,
                  // padding: const EdgeInsets.only(top: 2),
                  child: CLGText(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle?.copyWith(color: newTextColor) ?? context.textTheme.bodyMedium?.copyWith(color: newTextColor),
                  ),
                ),
              ),
              if ((isActive || markToday) && style == CLGDateStyleType.line)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(color: activeColor ?? context.theme.calendarActiveColor, height: 4),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
