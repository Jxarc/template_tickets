part of '../clg_dropdown.dart';

class _Dropdown<T> extends StatelessWidget {
  final List<CLGDropdownItem<T>>? values;
  final ValueChanged<T?>? onChanged;
  final T? initialValue;
  final double height;
  final double? width;
  final bool enable;
  final String hintText;
  final TextStyle? hintStyle;

  final Color? backgroundColor;
  final double borderWidth;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final bool showIcon;
  final EdgeInsets? padding;
  const _Dropdown({
    super.key,
    required this.values,
    this.height = _defaultHeight,
    this.width,
    this.onChanged,
    this.initialValue,
    this.enable = true,
    this.hintText = '',
    this.borderWidth = 0.5,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.icon,
    this.hintStyle,
    this.padding,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: enable ? (backgroundColor ?? context.theme.dropDownBackgroundColor) : context.theme.gray.shade100.withOpacity(0.5),
      padding: padding ?? const EdgeInsets.only(left: 15, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? _borderDefault.borderRadius,
      ),
      side: BorderSide(
        color: borderColor ?? context.theme.borderColor,
        width: borderWidth,
      ),
    );

    final iconSize = (height * 0.52) > 30 ? 30.0 : (height * 0.5);

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: enable ? () => _showDialog(context) : null,
        style: buttonStyle,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: _getText(context),
              ),
            ),
            if (showIcon)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: icon ??
                    CLGIcon(
                      path: CLGIcons.angleDown,
                      size: iconSize,
                      color: context.theme.primary,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getText(BuildContext context) {
    var (selected, _) = _getSelected();
    return selected != null
        ? CLGText(
            selected.label!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.gray.shade400,
            ),
          )
        : CLGText(
            hintText,
            style: hintStyle ?? TextStyle(color: context.theme.dropDownTextColor),
          );
  }

  (CLGDropdownItem<T>?, int index) _getSelected() {
    CLGDropdownItem<T>? selected;
    int index = -1;
    List.generate(values?.length ?? 0, (i) {
      if (initialValue == values?[i].value) {
        selected = values?[i];
        index = i;
      }
    });

    return (selected, index);
  }

  void _showDialog(BuildContext context) async {
    if (values?.isEmpty ?? false) return;
    final (_, index) = _getSelected();
    final results = await CLGSelect.show(context,
        initialValues: [index],
        children: (values ?? [])
            .map(
              (e) => CLGSelectOption(
                title: e.label ?? '',
                data: e.value,
              ),
            )
            .toList());

    if (results != null) {
      onChanged!(results.first.data);
    }
  }
}
