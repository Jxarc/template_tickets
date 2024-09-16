import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CLGSelectType {
  dialog,
  bottom,
}

class CLGSelectOption<T> {
  final String title;
  final String? subtitle;
  final Widget? prefix;
  final Widget? suffix;
  final T? data;

  CLGSelectOption({
    this.title = '',
    this.subtitle,
    this.prefix,
    this.suffix,
    this.data,
  });
}

class CLGSelect extends StatefulWidget {
  static Future<List<CLGSelectOption>?> show(
    BuildContext context, {
    CLGSelectType type = CLGSelectType.bottom,
    String? title,
    String? subtitle,
    Widget? prefixIcon,
    VoidCallback? onClose,
    List<int> initialValues = const [],
    List<CLGSelectOption> children = const [],
    bool isConfirm = false,
    bool isMultiple = false,
    String? buttonText,
    Widget? buttonIcon,
  }) {
    final child = CLGSelect(
      title: title,
      subtitle: subtitle,
      prefixIcon: prefixIcon,
      onClose: onClose,
      initialValues: initialValues,
      children: children,
      isConfirm: isConfirm,
      isMultiple: isMultiple,
      buttonIcon: buttonIcon,
      buttonText: buttonText,
    );

    if (type == CLGSelectType.dialog) {
      return showDialog<List<CLGSelectOption>>(
        context: context,
        builder: (context) => Dialog(
          child: child,
        ),
      );
    }

    return showModalBottomSheet<List<CLGSelectOption>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }

  final String? title;
  final String? subtitle;
  final Widget? prefixIcon;
  final VoidCallback? onClose;
  final List<int> initialValues;
  final List<CLGSelectOption> children;
  final bool isConfirm;
  final bool isMultiple;
  final String? buttonText;
  final Widget? buttonIcon;

  const CLGSelect({
    super.key,
    this.title,
    this.prefixIcon,
    this.onClose,
    this.subtitle,
    this.initialValues = const [],
    this.children = const [],
    this.isConfirm = false,
    this.isMultiple = true,
    this.buttonIcon,
    this.buttonText,
  });

  @override
  State<CLGSelect> createState() => _CLGSelectState();
}

class _CLGSelectState extends State<CLGSelect> {
  final List<int> _selecteds = [];

  @override
  void initState() {
    _selecteds.addAll(widget.initialValues);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final defaultMaxHeight = MediaQuery.of(context).size.height * 0.7;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.theme.background.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: widget.prefixIcon != null || widget.title != null || widget.onClose != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Visibility(
                      visible: widget.prefixIcon != null,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: widget.prefixIcon,
                      ),
                    ),
                    Expanded(
                      child: CLGText(
                        widget.title ?? '',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.gray.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.onClose != null,
                      child: CLGImageButton(
                        elevation: 0,
                        color: context.theme.shadowColor.shade100,
                        onClick: widget.onClose,
                        icon: CLGIcon(
                          path: CLGIcons.close,
                          color: context.theme.gray.shade300,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.subtitle != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: CLGText(
                  widget.subtitle ?? '',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.gray.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CLGAdaptiveList(
                maxHeight: defaultMaxHeight,
                itemCount: widget.children.length,
                spacing: 5,
                itemBuilder: (context, index) {
                  final item = widget.children[index];
                  final selected = _selecteds.isEmpty ? -1 : _selecteds.first;
                  final isCheck = _isChecked(index);
                  return CLGClick(
                    backgroundColor: isCheck ? context.theme.primary : context.theme.background,
                    rippleColor: !isCheck ? context.theme.gray.shade300.withOpacity(0.1) : context.theme.primary.shade900.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    onClick: () => _onChanged(index),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Visibility(
                            visible: !widget.isMultiple,
                            child: CLGRadio(
                              value: index,
                              groupValue: selected,
                              size: CLGRadioSize.large,
                              onChanged: (value) => _onChanged(index),
                            ),
                          ),
                          Visibility(
                            visible: widget.isMultiple,
                            child: CLGCheckbox(
                              value: isCheck,
                              onChanged: (value) => _onChanged(index),
                              size: CLGCheckboxSize.small,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Visibility(
                            visible: item.prefix != null,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: item.prefix,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CLGText(
                                  item.title,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: isCheck ? context.theme.white : context.theme.black,
                                  ),
                                ),
                                if (item.subtitle != null)
                                  CLGText(
                                    item.subtitle!,
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: isCheck ? context.theme.white : context.theme.gray.shade400,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: item.suffix != null,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: item.suffix,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: widget.isConfirm,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CLGButton(
                  elevation: 0,
                  width: double.infinity,
                  height: 45,
                  text: widget.buttonText ?? context.strings.accept,
                  suffixIcon: widget.buttonIcon,
                  onClick: widget.isMultiple || _selecteds.isNotEmpty ? _confirm : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onChanged(int index) {
    if (widget.isMultiple) {
      _onCheck(index);
    } else {
      _selecteds.isEmpty ? _selecteds.add(index) : _selecteds[0] = index;
    }

    if (widget.isConfirm) {
      setState(() {});
    } else {
      _confirm();
    }
  }

  void _onCheck(int index) {
    if (_isChecked(index)) {
      final newChecks = _selecteds.where((e) => e != index).toList();
      _selecteds.clear();
      _selecteds.addAll(newChecks);
    } else {
      _selecteds.add(index);
    }
  }

  void _confirm() {
    Navigator.pop(context, _selecteds.map((e) => widget.children[e]).toList());
  }

  bool _isChecked(int index) => _selecteds.where((e) => e == index).isNotEmpty;
}
