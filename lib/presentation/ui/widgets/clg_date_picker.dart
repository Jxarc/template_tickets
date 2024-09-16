import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:intl/intl.dart';

class CLGDatePicker extends StatefulWidget {
  final Function(DateTime) onChanged;
  final Locale? locale;
  final DateTime initialDate;
  final DateTime lastDate;
  final bool enabledHour;
  final bool enabledCalendar;
  final String? title;
  final Widget? header;
  final VoidCallback? onClose;
  final String? timeZone;
  final Duration? timeZoneOffset;
  final CLGDatePickerSettings initialSettings;

  const CLGDatePicker({
    super.key,
    required this.onChanged,
    required this.locale,
    required this.initialDate,
    required this.lastDate,
    required this.enabledHour,
    required this.enabledCalendar,
    required this.initialSettings,
    this.timeZone,
    this.timeZoneOffset,
    this.title,
    this.header,
    this.onClose,
    @Deprecated(
      'Please remove any reference to it. instead of use [header] to set a custom header. '
      'This feature was deprecated after v1.31.1',
    )
    String? subtitle,
  });

  @override
  State<CLGDatePicker> createState() => CLGDatePickerState();
}

class CLGDatePickerState extends State<CLGDatePicker> {
  DateTime _selected = DateTime.now();
  Duration _duration = Duration.zero;

  @override
  void initState() {
    final initialDate = CLGUtils.applyTimeZone(widget.initialDate, widget.timeZoneOffset);
    final totalMiliseconds = initialDate.millisecondsSinceEpoch;
    _selected = DateUtils.dateOnly(initialDate);
    _duration = Duration(milliseconds: totalMiliseconds - _selected.millisecondsSinceEpoch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: context.theme.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Visibility(
                visible: widget.title != null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: _HeaderModal(
                    title: widget.title,
                    onClosed: widget.onClose ?? () => Navigator.pop(context),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.72),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.header != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: widget.header ?? const SizedBox(),
                        ),
                      if (widget.title != null) const SizedBox(height: 5),
                      Visibility(
                        visible: widget.enabledCalendar,
                        child: CLGDate(
                          locale: widget.locale,
                          style: CLGDateStyle(),
                          showTodayIndicator: true,
                          datesSelected: [_selected],
                          initialDate: CLGUtils.applyTimeZone(widget.initialSettings.initialDate ?? widget.initialDate, widget.timeZoneOffset),
                          lastDate: widget.initialSettings.lastDate ?? widget.lastDate,
                          firstDate: widget.initialSettings.firstDate,
                          inactiveWeekdays: widget.initialSettings.inactiveWeekdays,
                          disabledDates: widget.initialSettings.disabledDates,
                          enabledDates: widget.initialSettings.enabledDates,
                          markedDates: widget.initialSettings.markedDates,
                          onDatesChanged: (value) {
                            _selected = value.first;
                            if (!widget.enabledHour) widget.onChanged(CLGDate.convertToTimeZone(value.first, widget.timeZoneOffset));
                          },
                        ),
                      ),
                      Visibility(
                        visible: widget.enabledHour,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: context.theme.primary.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              CLGTime(
                                is24Hour: widget.initialSettings.is24Hour,
                                minutesInterval: widget.initialSettings.minutesInterval,
                                hoursInterval: widget.initialSettings.hoursInterval,
                                itemWidth: 45,
                                itemHeight: 45,
                                spacing: 20,
                                initialValue: _duration,
                                textStyle: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.gray.shade400,
                                ),
                                onChange: (duration) {
                                  _duration = duration;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.enabledHour,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: CLGButton(
                    expandContent: true,
                    text: context.strings.accept,
                    elevation: 0,
                    height: 45,
                    onClick: () {
                      _selected = DateUtils.dateOnly(_selected).add(_duration);
                      widget.onChanged(CLGDate.convertToTimeZone(_selected, widget.timeZoneOffset));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderModal extends StatelessWidget {
  final String? title;
  final Function()? onClosed;
  const _HeaderModal({
    this.title,
    this.onClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CLGText(
            title ?? '',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.theme.gray.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CLGImageButton(
          elevation: 0,
          color: context.theme.gray.shade100,
          icon: CLGIcon(
            color: context.theme.gray.shade400,
            path: CLGIcons.close,
          ),
          onClick: onClosed,
        )
      ],
    );
  }
}

class CLGDatePickerSettings {
  final DateTime? initialDate;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final List<CLGWeekday> inactiveWeekdays;
  final List<CLGMarkDate> markedDates;
  final List<DateTime> enabledDates;
  final List<DateTime> disabledDates;
  final List<DateTime> datesSelected;
  final int minutesInterval;
  final int hoursInterval;
  final bool is24Hour;

  const CLGDatePickerSettings({
    this.initialDate,
    this.lastDate,
    this.firstDate,
    this.inactiveWeekdays = const [],
    this.markedDates = const [],
    this.enabledDates = const [],
    this.disabledDates = const [],
    this.datesSelected = const [],
    this.minutesInterval = 1,
    this.hoursInterval = 1,
    this.is24Hour = false,
  });
}

class CLGTimeZoneHeader extends StatefulWidget {
  final String? title;
  final String? timeZone;
  final Duration? offset;
  const CLGTimeZoneHeader({
    super.key,
    this.title,
    this.timeZone,
    this.offset,
  });

  @override
  State<CLGTimeZoneHeader> createState() => _CLGTimeZoneHeaderState();
}

class _CLGTimeZoneHeaderState extends State<CLGTimeZoneHeader> {
  final _formatter1 = DateFormat('dd/MM/yyyy');
  final _formatter2 = DateFormat('hh:mm:ss a');

  DateTime _date = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _date = DateTime.now();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final date = CLGUtils.applyTimeZone(_date, widget.offset);
    return CLGCard(
      color: context.theme.primary.shade100,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CLGText(
                    widget.title ?? context.strings.timezone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.black,
                    ),
                  ),
                  CLGText(
                    widget.timeZone ?? _date.timeZoneName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CLGCard(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CLGText(
                      _formatter1.format(date),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.theme.gray.shade400,
                      ),
                    ),
                    CLGText(
                      _formatter2.format(date),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.theme.gray.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
