import 'dart:io';

import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

enum CLGMapType {
  apple,
  google,
  uber,
  waze;

  static List<CLGMapType> get maps => CLGMapType.values.where((e) => Platform.isAndroid ? e != CLGMapType.apple : true).toList();

  String get title => switch (this) {
        CLGMapType.apple => 'Apple Maps',
        CLGMapType.google => 'Google Maps',
        CLGMapType.uber => 'Uber',
        CLGMapType.waze => 'Waze',
      };

  String get url => switch (this) {
        CLGMapType.apple => 'http://maps.apple.com/?q=',
        CLGMapType.google => 'https://maps.google.com/maps/search/',
        CLGMapType.uber => 'https://m.uber.com/ul/?pickup[formatted_address]=',
        CLGMapType.waze => 'https://www.waze.com/ul?q='
        //CLGMapType.uber => 'uber://?pickup[formatted_address]=',
        //CLGMapType.waze => 'waze://?q=',
      };

  String get androidAppId => switch (this) {
        CLGMapType.apple => '',
        CLGMapType.google => 'com.google.android.apps.maps',
        CLGMapType.uber => 'com.ubercab',
        CLGMapType.waze => 'com.waze',
      };

  String get iosAppId => switch (this) {
        CLGMapType.apple => 'apple-maps/id915056765',
        CLGMapType.google => 'google-maps/id585027354',
        CLGMapType.uber => 'uber-request-a-ride/id368677368',
        CLGMapType.waze => 'waze-navigation-live-traffic/id323229106',
      };

  Future open(BuildContext context, String address) async {
    final result = await CLGUtils.openUrl(context, '$url$address', showMessage: false);
    if (context.mounted && !result) {
      final appStore = Platform.isAndroid ? CLGConfig.appsAndroidUrl : CLGConfig.appsIOsUrl;
      final appId = Platform.isAndroid ? androidAppId : iosAppId;
      await CLGUtils.openUrl(context, '$appStore$appId', mode: CLGLaunchMode.externalApplication, showMessage: false);
    }
  }
}
