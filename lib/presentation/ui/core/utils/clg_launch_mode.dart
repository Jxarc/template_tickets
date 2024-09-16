import 'package:url_launcher/url_launcher_string.dart';

enum CLGLaunchMode {
  platformDefault,
  inAppWebView,
  externalApplication,
  externalNonBrowserApplication,
}

extension CLGLaunchModeExtension on CLGLaunchMode {
  LaunchMode get mode {
    switch (this) {
      case CLGLaunchMode.platformDefault:
        return LaunchMode.platformDefault;
      case CLGLaunchMode.inAppWebView:
        return LaunchMode.inAppWebView;
      case CLGLaunchMode.externalApplication:
        return LaunchMode.externalApplication;
      case CLGLaunchMode.externalNonBrowserApplication:
        return LaunchMode.externalNonBrowserApplication;
    }
  }
}
