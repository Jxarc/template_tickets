import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

enum CLGRadioSize { large, normal, small }

extension _CLGRadioSize on CLGRadioSize {
  double get size {
    switch (this) {
      case CLGRadioSize.large:
        return 25;
      case CLGRadioSize.normal:
        return 20;
      case CLGRadioSize.small:
        return 16;
    }
  }
}

class CLGRadio extends StatelessWidget {
  final int value;
  final int groupValue;
  final CLGRadioSize size;
  final ValueChanged<int?> onChanged;
  final Color? activeColor;
  final Color? borderColor;
  final bool enable;

  const CLGRadio({
    super.key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    this.enable = true,
    this.activeColor,
    this.borderColor,
    this.size = CLGRadioSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    return _CustomRadio(
      enable: enable,
      iconData: Icons.circle,
      groupValue: groupValue,
      activeColor: activeColor,
      size: size,
      value: value,
      onChanged: onChanged,
      borderColor: borderColor,
      borderWidth: size.size * 0.09,
    );
  }
}

class _CustomRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final CLGRadioSize size;
  final IconData iconData;
  final Color? activeColor;
  final Color? borderColor;
  final double borderWidth;
  final bool enable;

  const _CustomRadio({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    this.size = CLGRadioSize.normal,
    this.iconData = Icons.check_rounded,
    this.activeColor,
    this.borderColor,
    this.borderWidth = 0.5,
    this.enable = true,
  }) : super(key: key);

  @override
  State<_CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<_CustomRadio> {
  var _state = false;

  @override
  Widget build(BuildContext context) {
    _state = widget.value == widget.groupValue;
    final activeColor = widget.activeColor ?? context.theme.radioActiveColor;
    final inactiveBorderColor = context.theme.radioInactiveBorderColor;
    final activeBorderColor = widget.borderColor ?? context.theme.radioActiveBorderColor;
    return CLGImageButton(
      size: widget.size.size,
      elevation: _state ? 1 : 0,
      color: _state ? activeColor : context.theme.radioInactiveColor,
      borderColor: !_state || !widget.enable ? inactiveBorderColor : activeBorderColor,
      borderWidth: widget.borderWidth,
      icon: _state
          ? CLGIcon2(
              widget.iconData,
              color: context.theme.radioOnActiveColor,
              size: widget.size.size * 0.6,
            )
          : null,
      onClick: widget.enable
          ? () {
              _state = !_state;
              setState(() {});
              widget.onChanged(widget.value);
            }
          : null,
    );
  }
}
