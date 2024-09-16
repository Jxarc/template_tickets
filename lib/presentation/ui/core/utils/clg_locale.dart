import 'dart:io';

import 'package:flutter/material.dart';

class CLGLocale {
  static final all = [
    const Locale('en'),
    const Locale('es'),
    const Locale('es', 'AR'),
    const Locale('es', 'CL'),
    const Locale('es', 'CO'),
    const Locale('es', 'MX'),
    const Locale('pt', 'BR'),
  ];

  /*static final all = [
    const Locale('am'),
    const Locale('arn'),
    const Locale('arn', 'CL'),
    const Locale('ca'),
    const Locale('ca', 'ES'),
    const Locale('de'),
    const Locale('en'),
    const Locale('en', 'GB'),
    const Locale('es'),
    const Locale('es', 'AR'),
    const Locale('es', 'CL'),
    const Locale('es', 'CO'),
    const Locale('es', 'EC'),
    const Locale('es', 'ES'),
    const Locale('es', 'MX'),
    const Locale('es', 'PY'),
    const Locale('es', 'UY'),
    const Locale('fr'),
    const Locale('he'),
    const Locale('he', 'IL'),
    const Locale('ht'),
    const Locale('it'),
    const Locale('pt'),
    const Locale('pt', 'BR'),
    const Locale('zh'),
  ];*/

  static Locale getInitialLocale() {
    final localeParts = '${Platform.localeName}_'.replaceAll('-', '_').split('_');
    var locale = Locale(localeParts[0], localeParts[1]);
    if (!CLGLocale.existLocale(locale)) {
      final languagesLocale = languagesFromLocale(locale);
      locale = languagesLocale.isEmpty ? const Locale('es') : languagesLocale[0];
    }
    return locale;
  }

  static int getIndexFromLocale(Locale locale) {
    var languageSelected = -1;

    for (int i = 0; i < CLGLocale.all.length; i++) {
      if (CLGLocale.all[i].toLanguageTag() == locale.toLanguageTag()) {
        languageSelected = i;
        break;
      }
      if (CLGLocale.all[i].languageCode == locale.languageCode) languageSelected = i;
    }

    if (languageSelected == -1) languageSelected = 0;
    return languageSelected;
  }

  static bool existLocale(Locale locale) {
    final locales = all.where((element) => element.languageCode == locale.languageCode && element.countryCode == locale.countryCode);
    return locales.toList().isNotEmpty;
  }

  static List<Locale> languagesFromLocale(Locale locale) {
    final languages = all.where((element) => element.languageCode == locale.languageCode);
    return languages.toList();
  }
}
