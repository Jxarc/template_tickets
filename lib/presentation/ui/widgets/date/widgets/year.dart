part of '../clg_date.dart';

class _Year extends StatelessWidget {
  final CLGDateStyleType style;
  final String text;
  final bool isActive;
  final Function onClick;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? activeColor;
  final Color? activeTextColor;
  const _Year({
    required this.text,
    required this.isActive,
    required this.onClick,
    required this.textColor,
    required this.activeColor,
    required this.activeTextColor,
    required this.textStyle,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final newActiveColor = activeColor ?? context.theme.calendarActiveColor;
    final isCircle = style == CLGDateStyleType.circleFilled || style == CLGDateStyleType.circleOutline;

    return Center(
      child: Material(
        color: (isActive && style == CLGDateStyleType.circleFilled) ? newActiveColor : Colors.transparent,
        shape: isActive && style == CLGDateStyleType.circleOutline
            ? RoundedRectangleBorder(
                side: BorderSide(
                width: 1,
                color: newActiveColor,
              ))
            : null,
        borderRadius: BorderRadius.circular(isCircle ? 100 : 0),
        child: InkWell(
          onTap: () => onClick(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CLGText(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle?.copyWith(
                          color: isActive ? activeTextColor ?? context.theme.calendarActiveColor : textColor ?? context.theme.calendarTextColor,
                        ) ??
                        context.textTheme.bodyMedium?.copyWith(
                          color: isActive ? activeTextColor ?? context.theme.calendarActiveColor : textColor ?? context.theme.calendarTextColor,
                        ),
                  ),
                ),
              ),
              if (isActive && style == CLGDateStyleType.line)
                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  color: newActiveColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
