import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clg_assets.dart';

final Set<String> _loadedFonts = {};

class CLGFonts {
  static const String _folderfonts = CLGAssets.folderFonts;
  static const String _nunito = '$_folderfonts/nunito/Nunito';
  static const String _ext = '.ttf';

  static const weight = {
    FontWeight.w100: 'Thin',
    FontWeight.w200: 'ExtraLight',
    FontWeight.w300: 'Light',
    FontWeight.w400: 'Regular',
    FontWeight.w500: 'Medium',
    FontWeight.w600: 'SemiBold',
    FontWeight.w700: 'Bold',
    FontWeight.w800: 'ExtraBold',
    FontWeight.w900: 'Black',
  };

  static TextStyle nunito({TextStyle? textStyle}) {
    textStyle ??= const TextStyle();

    final fontWeight = textStyle.fontWeight ?? FontWeight.w400;
    final fontAsset = '$_nunito-${weight[fontWeight]}$_ext';

    _loadfont(CLGFontVariant(family: 'nunito', asset: fontAsset));
    return textStyle.copyWith(fontFamily: 'nunito');
  }

  static Future<void> _loadfont(CLGFontVariant variant) async {
    final familyWithVariantString = variant.toString();
    if (_loadedFonts.contains(familyWithVariantString)) {
      return;
    } else {
      _loadedFonts.add(familyWithVariantString);
    }

    final byteData = rootBundle.load(variant.asset);
    final fontLoader = FontLoader(variant.family);
    fontLoader.addFont(Future.value(byteData));
    await fontLoader.load();
  }
}

class CLGFontVariant {
  String family;
  String asset;
  CLGFontVariant({
    required this.family,
    required this.asset,
  });

  @override
  String toString() => '${family}_$asset';
}
