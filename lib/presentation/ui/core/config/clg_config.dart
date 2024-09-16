import 'package:flutter_dotenv/flutter_dotenv.dart';

enum CLGEnvironment {
  development,
  beta,
  demo,
  staging,
  production,
}

class CLGConfig {
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Constants
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  static const String env = 'ENV';
  static const String folderEnv = 'packages/colegium_package/assets/environments';
  static const String cacheDBName = 'colegium';

  static const String prefOpenAiToken = 'open_ai_token';
  static const String prefUnlayerToken = 'unlayer_token';
  static const String prefCalificationScales = 'calification_scales';
  static const String prefUserId = 'user_id';
  static const String prefUserToken = 'user_token';
  static const String prefChangePassword = 'change_password';
  static const String prefCustomTheme = 'custom_theme';
  static const String prefCommunityBirhdays = 'date_community_birthdays';
  static const String publicS3Host = 'https://colegium.s3.amazonaws.com/';
  static const String genericTokenAPI3 =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZ29zY2hvb2wuY29tLmFyIiwiYXVkIjoiaHR0cHM6XC9cL2dvc2Nob29sLmNvbS5hciIsImlhdCI6MTU1MjQyMzQwNCwidWlkIjoiR1MifQ.ZZ6xUZo0Hj8uVd9QmaA-LnoVCtLOUfwEKiB4u81Trvk';
  static const String genericToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2dvc2Nob29sLmNvbS5hciIsImF1ZCI6Imh0dHBzOi8vZ29zY2hvb2wuY29tLmFyIiwiaWF0IjoxNTUyNDIzNDA0LCJ1aWQiOiJHUyJ9.dwa9OHeJ97sH1vayRzGi9dq40Q9wM-zTS-_GJsgy5xw';

  static const String privacyPolicyUrl = 'https://www.colegium.com/politicas-de-privacidad';
  static const String termsAndConditionsUrl = 'https://www.colegium.com/condiciones-de-uso';

  static const String playstoreUrl = 'https://play.google.com';
  static const playstoreAppUrl = '$playstoreUrl/store/apps/details?id=:idapp';
  static const playstoreSheetId = 'com.google.android.apps.docs.editors.sheets';
  static const playstoreDocsId = 'com.google.android.apps.docs.editors.docs';
  static const playstoreSlidesId = 'com.google.android.apps.docs.editors.slides';
  static const playstorePdfId = 'com.adobe.reader';

  static const String tinyKey = 'uO9dr4ARD3wYs1PqJKe8gvo5VNShxEUXkHI72M0GcTaWZyjtzlCnLBQ6Ffipmb';

  static const appsIOsUrl = 'https://apps.apple.com/us/app/';
  static const appsAndroidUrl = 'https://play.google.com/store/apps/details?id=';

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // Properties
  //------------------------------------------------------------------------------------------------------------------------------------------------------

  static String get api3Host => dotenv.get('API3_HOST');
  static String get api4Host => dotenv.get('API4_HOST');
  static String get api5Host => dotenv.get('API5_HOST');
  static String get apiEFHost => dotenv.get('API_EF_HOST');
  static String get apiSNHost => dotenv.get('API_SN_HOST');

  static String get environment => dotenv.get('ENV');

  static String get defaultS3Path => ([
        CLGEnvironment.production.name,
        CLGEnvironment.staging.name,
        CLGEnvironment.demo,
      ].contains(CLGConfig.environment)
          ? 'uploads'
          : 'uploads_dev');
}
