import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/cupertino.dart';

class CLGTime extends StatelessWidget {
  final double itemHeight;
  final double itemWidth;
  final double spacing;
  final bool is24Hour;
  final Function(Duration) onChange;
  final Duration? initialValue;
  final int minutesInterval;
  final int hoursInterval;

  final Color? textColor;
  final TextStyle? textStyle;
  final Color? indicatorColor;

  const CLGTime({
    super.key,
    required this.onChange,
    this.itemHeight = 30,
    this.itemWidth = 26,
    this.spacing = 10,
    this.minutesInterval = 1,
    this.hoursInterval = 1,
    this.is24Hour = false,
    this.initialValue,
    this.textColor,
    this.textStyle,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final controller = initialValue != null
        ? _TimeController.fromDuration(
            onChange: onChange,
            is24Hours: is24Hour,
            duration: initialValue!,
          )
        : _TimeController(
            onChange: onChange,
            is24Hours: is24Hour,
          );

    final style = _TimeStyle(
      indicatorColor: indicatorColor,
      textStyle: textStyle,
      textColor: textColor,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Hours(
          style: style,
          controller: controller,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          is24Hour: is24Hour,
          hoursInterval: hoursInterval,
        ),
        SizedBox(width: spacing),
        _Minutes(
          style: style,
          controller: controller,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          minutesInterval: minutesInterval,
        ),
        if (!is24Hour) ...[
          SizedBox(width: spacing),
          _JA(
            style: style,
            controller: controller,
            itemHeight: itemHeight,
            itemWidth: itemWidth,
          ),
        ]
      ],
    );
  }
}

class _Hours extends StatelessWidget {
  final _TimeController controller;
  final _TimeStyle? style;
  final double itemHeight;
  final double itemWidth;
  final bool is24Hour;
  final int hoursInterval;
  const _Hours({
    super.key,
    required this.itemHeight,
    required this.itemWidth,
    required this.controller,
    this.is24Hour = false,
    this.style,
    this.hoursInterval = 1,
  });

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    if (!is24Hour) {
      for (int i = 0; i < 12; i += hoursInterval) {
        list.add((i + 1).toString().padLeft(2, '0'));
      }
    } else {
      for (int i = 0; i < 24; i += hoursInterval) {
        list.add(i.toString().padLeft(2, '0'));
      }
    }
    return _Item(
      style: style,
      itemHeight: itemHeight,
      itemWidth: itemWidth,
      list: list,
      value: controller._hourSelected,
      onChange: (value) {
        final hour = int.tryParse(list[value]) ?? 0;
        controller.hourSelected = is24Hour ? hour : hour - 1;
      },
    );
  }
}

class _Minutes extends StatelessWidget {
  final _TimeController controller;
  final _TimeStyle? style;
  final double itemHeight;
  final double itemWidth;
  final int minutesInterval;

  const _Minutes({
    super.key,
    required this.itemHeight,
    required this.itemWidth,
    required this.controller,
    this.minutesInterval = 1,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    List<String> items = [];
    for (int i = 0; i < 60; i += minutesInterval) {
      items.add(i.toString().padLeft(2, '0'));
    }

    return _Item(
      style: style,
      itemHeight: itemHeight,
      itemWidth: itemWidth,
      value: controller._minuteSelected,
      list: items,
      onChange: (value) {
        controller.minuteSelected = int.tryParse(items[value]) ?? 0;
      },
    );
  }
}

class _JA extends StatelessWidget {
  final _TimeController controller;
  final _TimeStyle? style;
  final double itemHeight;
  final double itemWidth;

  const _JA({
    super.key,
    required this.itemHeight,
    required this.itemWidth,
    required this.controller,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return _Item(
      style: style,
      itemHeight: itemHeight,
      itemWidth: itemWidth,
      value: controller._jaSelected,
      list: const ['Am', 'Pm'],
      onChange: (value) {
        controller.jaSelected = value;
      },
    );
  }
}

class _Item extends StatefulWidget {
  final _TimeStyle? style;
  final double itemHeight;
  final double itemWidth;
  final List<String> list;
  final Function(int) onChange;
  final int value;
  const _Item({
    super.key,
    this.list = const [],
    required this.itemHeight,
    required this.itemWidth,
    required this.onChange,
    this.value = 0,
    this.style,
  });

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    _controller = FixedExtentScrollController(initialItem: widget.value);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.itemWidth,
      height: 100,
      child: CupertinoPicker.builder(
        childCount: widget.list.length,
        itemExtent: widget.itemHeight,
        scrollController: _controller,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: widget.style?.indicatorColor ?? context.theme.primary.shade500,
                width: 1.5,
              ),
            ),
          ),
        ),
        onSelectedItemChanged: widget.onChange,
        itemBuilder: (context, index) {
          return Center(
            child: CLGText(
              widget.list[index],
              style: widget.style?.textStyle?.copyWith(
                    color: widget.style?.textColor ?? const Color(0xff505068),
                  ) ??
                  context.textTheme.bodyLarge?.copyWith(
                    color: widget.style?.textColor ?? const Color(0xff505068),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class _TimeController {
  final bool is24Hours;
  final Function(Duration) onChange;

  int _hourSelected = 0;
  int get hourSelected => _hourSelected;
  set hourSelected(int val) {
    _hourSelected = val;
    _callbackDuration();
  }

  int _minuteSelected = 0;
  int get minuteSelected => _minuteSelected;
  set minuteSelected(int val) {
    _minuteSelected = val;
    _callbackDuration();
  }

  int _jaSelected = 0;
  int get jaSelected => _jaSelected;
  set jaSelected(int val) {
    _jaSelected = val;
    _callbackDuration();
  }

  _TimeController({
    required this.onChange,
    required this.is24Hours,
  });

  _TimeController.fromDuration({
    required Duration duration,
    required this.onChange,
    required this.is24Hours,
  }) {
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    _hourSelected = hours;
    _minuteSelected = minutes;

    if (!is24Hours) {
      _hourSelected = hours - 1;

      if (hours == 0) {
        _jaSelected = 0;
        _hourSelected = 11;
      }

      if (hours == 12) {
        _jaSelected = 1;
        _hourSelected = 11;
      }

      if (hours > 12) {
        _jaSelected = 1;
        _hourSelected = hours - 13;
      }
    }
  }

  _callbackDuration() {
    var hoursCallback = hourSelected;

    if (!is24Hours) {
      hoursCallback = hourSelected + 1;

      if (jaSelected == 0 && hoursCallback == 12) {
        hoursCallback = 0;
      }

      if (jaSelected == 1 && hoursCallback != 12) {
        hoursCallback = 12 + hourSelected + 1;
      }

      if (hoursCallback == 24) {
        hoursCallback = 0;
      }
    }

    onChange(Duration(
      hours: hoursCallback,
      minutes: minuteSelected,
    ));
  }
}

class _TimeStyle {
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? indicatorColor;

  _TimeStyle({
    this.textColor,
    this.textStyle,
    this.indicatorColor,
  });
}
