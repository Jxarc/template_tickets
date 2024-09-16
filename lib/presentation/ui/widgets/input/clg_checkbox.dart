import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

enum CLGCheckboxSize { large, normal, small }

extension _CLGCheckboxSize on CLGCheckboxSize {
  double get size {
    switch (this) {
      case CLGCheckboxSize.large:
        return 27;
      case CLGCheckboxSize.normal:
        return 22;
      case CLGCheckboxSize.small:
        return 18;
    }
  }
}

extension _BoxShapeExtension on BoxShape {
  double get radius {
    switch (this) {
      case BoxShape.rectangle:
        return 5;
      case BoxShape.circle:
        return 30;
    }
  }
}

class CLGCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? checkColor;
  final Color? borderColor;
  final double borderWidth;
  final IconData iconData;
  final bool enable;
  final CLGCheckboxSize size;
  final BoxShape? shape;

  const CLGCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.iconData = Icons.check_rounded,
    this.checkColor,
    this.borderColor,
    this.size = CLGCheckboxSize.normal,
    this.enable = true,
    this.borderWidth = 1,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CustomCheckbox(
      value: value,
      onChanged: onChanged,
      activeColor: checkColor,
      enable: enable,
      iconData: iconData,
      size: size,
      borderColor: borderColor,
      borderWidth: borderWidth,
      shape: shape,
    );
  }
}

class _CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final CLGCheckboxSize size;
  final IconData iconData;
  final Color? activeColor;
  final Color? borderColor;
  final double borderWidth;
  final bool enable;
  final BoxShape? shape;

  const _CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = CLGCheckboxSize.normal,
    this.iconData = Icons.check_rounded,
    this.activeColor,
    this.borderColor,
    this.borderWidth = 1,
    this.enable = true,
    this.shape,
  }) : super(key: key);

  @override
  State<_CustomCheckbox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<_CustomCheckbox> {
  var _state = false;

  @override
  Widget build(BuildContext context) {
    _state = widget.value;

    return CLGImageButton(
      borderRadius: widget.shape?.radius,
      size: widget.size.size,
      elevation: _state ? 2 : 0,
      color: _state ? widget.activeColor ?? context.theme.checkBoxActiveColor : context.theme.checkBoxInactiveColor,
      borderColor: widget.borderColor ?? context.theme.gray.shade200,
      borderWidth: !widget.enable || _state ? 0 : widget.borderWidth,
      icon: _state
          ? CLGIcon2(
              widget.iconData,
              color: !widget.enable ? context.theme.disabledColor : context.theme.checkBoxOnActiveColor,
              size: widget.size.size * 0.9,
            )
          : null,
      onClick: widget.enable
          ? () {
              setState(() {
                _state = !_state;
              });
              widget.onChanged(_state);
            }
          : null,
    );
  }
}
