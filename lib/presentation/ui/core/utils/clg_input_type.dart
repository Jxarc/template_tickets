import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CLGInputType {
  password,
  email,
  phone,
  alphanumeric,
  number,
  numberDecimal,
  multiline,
}

extension CLGInputTypeExtension on CLGInputType {
  String? get regex {
    switch (this) {
      case CLGInputType.password:
      case CLGInputType.multiline:
      case CLGInputType.alphanumeric:
        break;
      case CLGInputType.phone:
        return r'^[\+\*#\d]+$';
      //^\+?\d{0,4}\s?\(?\d{3}\)?(\s?\d{3})?\s?\d{4}$ - +54 (555) 555 5555
      case CLGInputType.number:
        return r'^\d+$';
      case CLGInputType.numberDecimal:
        return r'^(\d+)?\.?,?\d+$';

      case CLGInputType.email:
        return r'^(?!\.)([a-zA-Z0-9-_\.]*\w)+@[a-zA-Z0-9\-_]*\.[a-zA-Z]+(\.[a-zA-Z]+)*$';
    }
    return null;
  }

  TextInputType? get textInputType {
    switch (this) {
      case CLGInputType.password:
      case CLGInputType.alphanumeric:
        return TextInputType.text;

      case CLGInputType.multiline:
        return TextInputType.multiline;

      case CLGInputType.email:
        return TextInputType.emailAddress;

      case CLGInputType.phone:
        return TextInputType.phone;

      case CLGInputType.number:
        return TextInputType.number;

      case CLGInputType.numberDecimal:
        return const TextInputType.numberWithOptions(decimal: true);
    }
  }

  bool valid(String text) {
    final regex = RegExp(this.regex ?? '');
    return regex.hasMatch(text);
  }
}

class CLGNumberDecimalFormatter extends TextInputFormatter {
  final int decimalRange;
  final int? min;
  final int? max;

  CLGNumberDecimalFormatter({
    this.decimalRange = 10,
    this.min,
    this.max,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(r'^-?[\d\.,]*$');
    String newText = newValue.text.replaceAll(',', '.');
    int offset = newValue.selection.baseOffset;

    if (newText.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: TextSelection.fromPosition(
          const TextPosition(offset: 0),
        ),
      );
    }
    if (!regex.hasMatch(newText)) {
      return oldValue;
    }

    if (newText.split('.').length > 1) {
      final text = newText.replaceFirst('.', '~').replaceAll('.', '').replaceAll('~', '.');

      if (text.length != newText.length) {
        final diff = newText.length - text.length;
        offset = offset - diff;
        newText = text;
      }
    }

    if (newText.split('.').length > 1) {
      final decimal = newText.split('.').last;
      if (decimal.length > decimalRange) {
        final newDecimals = decimal.substring(0, decimalRange);
        final text = '${newText.split('.').first}.$newDecimals';
        offset = text.length;
        newText = text;
      } else if (decimalRange == 0) {
        final text = newText.replaceAll('.', '');
        offset = text.length;
        newText = text;
      }
    }

    if (max != null) {
      final number = num.parse(newText);
      if (number > max!) {
        if (!newText.contains('.') && decimalRange > 0 && offset > 0) {
          final crop = newText.substring(0, offset - 1);
          final text = '$crop.${newText.substring(offset - 1)}';
          final diff = text.length - newText.length;
          offset = offset + diff;
          newText = text;
        }
      }

      final newNumber = num.parse(newText);
      if (newNumber > max!) {
        final text = max.toString();
        final diff = text.length - newText.length;
        offset = offset + diff;
        offset = offset < 0 ? 0 : offset;
        newText = text;
      }
    }

    if (min != null) {
      final number = num.parse(newText);
      if (number < min!) {
        final text = min.toString();
        final diff = text.length - newText.length;
        offset = offset + diff;
        offset = offset < 0 ? 0 : offset;
        newText = text;
      }
    }

    if (!newText.endsWith('.') && newText.isNumeric) {
      final number = num.parse(newText);
      if (number.toString().length != newText.length) {
        final diff = newText.length - number.toString().length;
        offset = offset - diff;
        newText = number.toString();
      }
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: offset),
      ),
    );
  }
}
