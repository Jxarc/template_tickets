import 'package:template/presentation/ui/ui.dart';
import 'package:html/parser.dart' show parse;

extension StringExtension on String {
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Public Methods
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String firstUpperCase() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toProperCase() {
    if (isEmpty) return '';

    final parts = split(' ');
    return parts.map((e) => e.capitalize()).join(' ').trim();
  }

  String parseHtmlString() {
    final document = parse(this);
    return parse(document.body!.text).documentElement!.text;
  }

  String interpolation(List<String> vars) {
    String text = this;
    for (var arg in vars) {
      text = text.replaceFirst(CLGUtils.interpolationRegex, arg);
    }
    return text;
  }

  String parseHtmlStringRegExp() {
    RegExp exp1 = RegExp(r'<br[^>]*>', multiLine: true, caseSensitive: true);
    RegExp exp2 = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);

    String result = this;
    result = result.replaceAll(exp1, ' ');
    result = result.replaceAll(exp2, '');
    result = result.replaceAll('&nbsp;', ' ');
    return result;
  }

  bool get isNumeric {
    try {
      num.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isUrl {
    try {
      final regex = RegExp(r'^https?://');
      return regex.hasMatch(this);
    } catch (e) {
      return false;
    }
  }

  String get noDiacritics {
    const accents = 'áéíóú';
    const noAccents = 'aeiou';
    String newText = toLowerCase().trim();

    for (final c in accents.split('')) {
      newText = newText.replaceAll(c, noAccents[accents.indexOf(c)]);
    }

    return newText;
  }
}
