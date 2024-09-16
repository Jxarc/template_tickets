import 'dart:ui' as ui show TextHeightBehavior;
import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const maxScale = 1.35;
const minScale = 0.18;

class CLGText extends Text {
  final double scalePercentage;
  final double? maxScaleFontSize;
  final double? minScaleFontSize;

  const CLGText(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    ui.TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
    this.scalePercentage = 5,
    this.maxScaleFontSize,
    this.minScaleFontSize,
  }) : super(
          data,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaler: const TextScaler.linear(1),
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);

    TextStyle newStyle = effectiveTextStyle ?? context.textTheme.bodyMedium ?? const TextStyle();
    double fontSize = newStyle.fontSize ?? 14.0;
    final finalSize = CLGText.getFontSize(
      context,
      fontSize: fontSize,
      scalePercentage: scalePercentage,
      minScaleFontSize: minScaleFontSize,
      maxScaleFontSize: maxScaleFontSize,
    );

    if (minScaleFontSize != null && minScaleFontSize! > fontSize) throw Exception('minScaleFontSize attribute must be less than fontSize');
    if (maxScaleFontSize != null && maxScaleFontSize! < fontSize) throw Exception('maxScaleFontSize attribute must be greater than fontSize');

    Widget result = RichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection, // RichText uses Directionality.of to obtain a default if this is null.
      locale: locale, // RichText uses Localizations.localeOf to obtain a default if this is null
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow: overflow ?? effectiveTextStyle?.overflow ?? defaultTextStyle.overflow,
      textScaleFactor: 1,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context),
      selectionRegistrar: registrar,
      selectionColor: selectionColor ?? DefaultSelectionStyle.of(context).selectionColor ?? DefaultSelectionStyle.defaultColor,
      text: TextSpan(
        style: newStyle.copyWith(fontSize: finalSize),
        text: data,
        children: textSpan != null ? <InlineSpan>[textSpan!] : null,
      ),
    );
    if (registrar != null) {
      result = MouseRegion(
        cursor: SystemMouseCursors.text,
        child: result,
      );
    }
    if (semanticsLabel != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }

  static double getFontSize(
    BuildContext context, {
    required double fontSize,
    double? minScaleFontSize,
    double? maxScaleFontSize,
    double? scalePercentage,
  }) {
    double scale = MediaQuery.textScaleFactorOf(context);

    final sizeWidthPercentage = (scalePercentage ?? 5) * fontSize / 100;
    final minValue = minScaleFontSize ?? (fontSize - sizeWidthPercentage);
    final maxValue = maxScaleFontSize ?? (fontSize + sizeWidthPercentage);

    var finalSize = fontSize;

    if (scale >= 1) {
      final percentage = (scale - 1) * 100 / (maxScale - 1) / 100;
      finalSize = fontSize + (percentage * (fontSize - maxValue).abs());
    } else {
      final percentage = (scale - 1) * 100 / minScale.abs() / 100;
      finalSize = fontSize + (percentage * (fontSize - minValue).abs());
    }

    return finalSize;
  }
}
