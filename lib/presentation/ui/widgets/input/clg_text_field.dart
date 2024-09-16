import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/services.dart';

const _defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 7);

class CLGTextField extends StatefulWidget {
  final ScrollController? scrollController;
  final CLGInputType type;
  final bool enable;
  final Color? backgroundDisabledColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;

  final String? hintText;
  final String? errorText;
  final String? helperText;

  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final TextStyle? hintStyle;

  final Color? textColor;
  final Color? errorColor;
  final Color? helperColor;
  final Color? hintColor;

  final double? width;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final int? maxLength;

  ///
  /// This property is used for disabled default validation.
  /// So, if you set in false will not show error message
  ///
  final bool validate;
  final bool autoFocus;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  /// This property is used for create or add a custom validation,
  /// you should be return a String with the error message.
  /// Try don't call setState inside [validator] function.
  ///Because this function is called many times to validate
  ///in realtime the input
  final String? Function(String val)? validator;

  ///
  /// This property is used for get the current state of validation
  ///
  final void Function(bool isValid)? validated;

  final GestureTapCallback? onClick;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;

  const CLGTextField({
    Key? key,
    this.type = CLGInputType.alphanumeric,
    this.textCapitalization,
    this.enable = true,
    this.width,
    this.hintText,
    this.errorText,
    this.helperText,
    this.controller,
    this.padding,
    this.maxLines = 1,
    this.validate = true,
    this.validator,
    this.validated,
    this.autoFocus = false,
    this.onClick,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.textStyle,
    this.errorStyle,
    this.helperStyle,
    this.hintStyle,
    this.textColor,
    this.errorColor,
    this.helperColor,
    this.hintColor,
    this.backgroundColor,
    this.backgroundDisabledColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.suffixIcon,
    this.prefixIcon,
    this.scrollController,
    this.inputFormatters,
    this.textAlign,
    this.maxLength,
  }) : super(key: key);

  @override
  State<CLGTextField> createState() => _CLGTextFieldState();
}

class _CLGTextFieldState extends State<CLGTextField> {
  bool _isValid = true;
  String? _errorText;

  @override
  void initState() {
    _errorText = widget.errorText;
    super.initState();
  }

  void _onChanged(val) {
    if (!widget.validate) return;

    if (widget.validator != null) {
      final res = widget.validator!(val);

      if (res != null) {
        if (_isValid || res != _errorText) {
          if (_isValid && widget.validated != null) widget.validated!(false);
          setState(() {
            _errorText = res;
            _isValid = false;
          });
        }
        return;
      }
    }

    final valid = _checkInput(val);
    if (valid != _isValid || (_errorText != widget.errorText && _errorText != 'Error')) {
      if (valid != _isValid && widget.validated != null) {
        widget.validated!(valid);
      }

      setState(() {
        _errorText = widget.errorText ?? 'Error';
        _isValid = valid;
      });
    }
  }

  bool _checkInput(val) {
    if (widget.type.regex != null) {
      return _checkRegex(widget.type.regex!, val);
    }
    return true;
  }

  bool _checkRegex(String regex, String text) {
    final regex = RegExp(widget.type.regex!);
    return regex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters = [
      if (widget.type == CLGInputType.email) FilteringTextInputFormatter.deny(RegExp(r'\s')),
      if (widget.type == CLGInputType.phone) FilteringTextInputFormatter.allow(RegExp(r'[\+\*\.#\d]')),
      if (widget.type == CLGInputType.number) FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
      if (widget.type == CLGInputType.numberDecimal) CLGNumberDecimalFormatter(),
      ...(widget.inputFormatters ?? []),
    ];
    return SizedBox(
      width: widget.width,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: CLGThemeData.textScaleFactorOf(context)),
        child: TextField(
          maxLength: widget.maxLength,
          textAlign: widget.textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters.isNotEmpty ? inputFormatters : null,
          scrollController: widget.scrollController,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          onTap: widget.onClick,
          style: widget.textStyle?.copyWith(
                color: widget.textColor ?? context.theme.textFieldTextColor,
              ) ??
              context.textTheme.bodyMedium?.copyWith(
                color: widget.textColor ?? context.theme.textFieldTextColor,
              ),
          autofocus: widget.autoFocus,
          onChanged: _onChanged,
          keyboardType: widget.type.textInputType,
          enabled: widget.enable,
          obscureText: CLGInputType.password == widget.type,
          obscuringCharacter: '●',
          cursorColor: context.theme.textFieldTextColor,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: widget.enable
                ? widget.backgroundColor ?? context.theme.textFieldBackgroundColor
                : widget.backgroundDisabledColor ?? context.theme.textFieldDisabledColor,
            errorText: widget.validate ? (!_isValid ? _errorText : null) : widget.errorText,
            errorStyle: widget.errorStyle?.copyWith(
                  color: widget.errorColor ?? context.theme.errorColor,
                ) ??
                context.textTheme.bodySmall?.copyWith(
                  color: widget.errorColor ?? context.theme.errorColor,
                ),
            helperText: widget.helperText,
            helperStyle: widget.helperStyle?.copyWith(
                  color: widget.helperColor ?? context.theme.textFieldHintColor,
                ) ??
                context.textTheme.bodySmall?.copyWith(
                  color: widget.helperColor ?? context.theme.textFieldHintColor,
                ),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle?.copyWith(
                  color: widget.hintColor ?? context.theme.textFieldHintColor,
                ) ??
                context.textTheme.bodySmall?.copyWith(
                  color: widget.hintColor ?? context.theme.textFieldHintColor,
                ),
            contentPadding: widget.padding ?? _defaultPadding,
            border: _borderDefault(context),
            focusedBorder: _borderDefault(context).copyWith(
              borderSide: BorderSide(
                width: widget.borderWidth ?? 0.5,
                color: widget.borderColor ?? context.theme.borderColor,
              ),
            ),
            enabledBorder: _borderDefault(context),
            disabledBorder: _borderDefault(context),
            focusedErrorBorder: _borderDefault(context).copyWith(
              borderSide: BorderSide(
                width: 1,
                color: context.theme.textFieldErrorColor,
              ),
            ),
            errorBorder: _borderDefault(context).copyWith(
              borderSide: BorderSide(
                width: 0.5,
                color: context.theme.textFieldErrorColor,
              ),
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _borderDefault(BuildContext context) => OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(7),
      borderSide: BorderSide(
        color: widget.borderColor ?? Theme.of(context).colorScheme.outline,
        width: widget.borderWidth ?? 0.5,
      ));
}
