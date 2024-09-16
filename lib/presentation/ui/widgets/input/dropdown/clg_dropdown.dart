import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

part 'widgets/_dropdown.dart';

final _borderDefault = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.5),
      width: 0.5,
    ));

const _defaultHeight = 50.0;

class CLGDropdownItem<T> {
  final String? label;
  final T value;

  ///final Widget child;

  CLGDropdownItem({
    required this.label,
    required this.value,
    //required this.child,
  });
}

class CLGDropdown<T> extends StatelessWidget {
  final List<CLGDropdownItem<T>>? values;
  final ValueChanged<T?>? onChanged;
  final T? initialValue;
  final double? height;
  final double? width;
  final bool enable;
  final String hintText;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;

  final Color? backgroundColor;
  final double borderWidth;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Widget? icon;

  const CLGDropdown({
    super.key,
    required this.values,
    this.height,
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
  });

  @override
  Widget build(BuildContext context) {
    return _Dropdown<T>(
      values: values,
      height: height ?? _defaultHeight,
      initialValue: initialValue,
      enable: enable,
      onChanged: onChanged,
      width: width,
      hintText: hintText,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      icon: icon,
      hintStyle: hintStyle,
      padding: padding,
    );
  }
}
