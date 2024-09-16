import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class CLGInputDateForm extends StatelessWidget {
  final String? title;
  final String? placeholder;
  final String? errorText;
  final TextEditingController controller;

  final Locale? locale;
  final Duration? timeZoneOffset;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool enabledHours;
  final bool enabledCalendar;
  final String format;
  final String? requiredText;
  final String? helperText;
  final VoidCallback? onChanged;
  final CLGDatePickerSettings initialSettings;

  const CLGInputDateForm({
    super.key,
    required this.controller,
    this.title,
    this.placeholder,
    this.errorText,
    this.locale,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.format = 'MMMM dd, yyyy',
    this.requiredText,
    this.helperText,
    this.enabledHours = false,
    this.enabledCalendar = true,
    this.onChanged,
    this.timeZoneOffset,
    this.initialSettings = const CLGDatePickerSettings(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CLGInputTitleForm(
            title: title,
            requiredText: requiredText,
          ),
          _FieldDate(
            enabled: enabled,
            title: title,
            controller: controller,
            placeholder: placeholder,
            enabledHours: enabledHours,
            enabledCalendar: enabledCalendar,
            format: format,
            locale: locale,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isError: errorText != null,
            initialDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
            onChanged: onChanged,
            initialSettings: initialSettings,
            timeZoneOffset: timeZoneOffset,
          ),
          CLGInputInfoForm(
            errorText: errorText,
            helperText: helperText,
          ),
        ],
      ),
    );
  }
}

class _FieldDate extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final Locale? locale;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final DateTime initialDate;
  final DateTime lastDate;
  final String format;
  final bool enabledHours;
  final bool enabledCalendar;
  final String? title;
  final bool isError;
  final VoidCallback? onChanged;
  final CLGDatePickerSettings initialSettings;
  final Duration? timeZoneOffset;

  const _FieldDate({
    required this.controller,
    required this.initialDate,
    required this.lastDate,
    required this.format,
    required this.enabledHours,
    required this.enabledCalendar,
    required this.initialSettings,
    this.placeholder,
    this.locale,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.title,
    this.isError = false,
    this.onChanged,
    this.timeZoneOffset,
  });

  @override
  State<_FieldDate> createState() => _FieldDateState();
}

class _FieldDateState extends State<_FieldDate> {
  String labelDate = '';
  String get defaultFormat => 'MMMM dd, yyyy${widget.enabledHours ? ' - hh:mm' : ''}';
  String get format => widget.format.isNotEmpty ? widget.format : defaultFormat;

  @override
  void initState() {
    _initText();
    super.initState();
  }

  void _initText() {
    labelDate = widget.placeholder ?? '';

    if (widget.controller.text.isNotEmpty && widget.controller.text.isNumeric) {
      final ms = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.controller.text));
      widget.controller.text = CLGDate.convertToTimeZone(ms, widget.timeZoneOffset).millisecondsSinceEpoch.toString();
      _refresh();
    }

    widget.controller.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isError ? context.theme.magenta : context.theme.gray.shade200,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: widget.enabled ? context.theme.white : context.theme.gray.shade100.withOpacity(0.5),
        child: InkWell(
          highlightColor: context.theme.primary.shade100.withOpacity(0.7),
          splashColor: context.theme.primary.shade100.withOpacity(0.7),
          onTap: widget.enabled ? () => _showDatePicker(context) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            child: Row(
              children: [
                Visibility(
                  visible: widget.prefixIcon != null,
                  child: widget.prefixIcon ?? const SizedBox(),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: CLGText(
                    widget.controller.text.isEmpty ? widget.placeholder ?? '' : labelDate,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: widget.controller.text.isEmpty ? context.theme.gray.shade300 : context.theme.black,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Visibility(
                  visible: widget.suffixIcon != null,
                  child: widget.suffixIcon ?? const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _refresh() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final formatter = DateFormat(format, widget.locale?.languageCode);
      DateTime date = DateTime.fromMillisecondsSinceEpoch(int.tryParse(widget.controller.text) ?? 0);

      date = CLGUtils.applyTimeZone(date, widget.timeZoneOffset);
      labelDate = formatter.format(date).capitalize();
      setState(() {});
    });
  }

  void _showDatePicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    DateTime initialDate = DateTime.now();
    if (widget.controller.text.isNotEmpty && widget.controller.text.isNumeric) {
      initialDate = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.controller.text));
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CLGDatePicker(
        timeZoneOffset: widget.timeZoneOffset,
        locale: widget.locale,
        enabledHour: widget.enabledHours,
        enabledCalendar: widget.enabledCalendar,
        initialDate: initialDate,
        lastDate: widget.lastDate,
        title: widget.title,
        initialSettings: widget.initialSettings,
        onChanged: (date) {
          Navigator.pop(context);
          widget.controller.text = date.millisecondsSinceEpoch.toString();
          if (widget.onChanged != null) widget.onChanged!();
        },
      ),
    );
  }
}
