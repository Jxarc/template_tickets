import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String get html {
    final text = toString();
    final regex = RegExp(r'Color\(0x(\w{2,2})(\w{6,6})\)');
    final result = regex.firstMatch(text);

    return '#${result?.group(2) ?? 'ffffff'}${result?.group(1) ?? 'ff'}';
  }
}
