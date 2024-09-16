import 'package:flutter/widgets.dart';
import 'package:template/presentation/ui/ui.dart';

enum CLGErrorType {
  networkConnection,
  serverConnection,
  serverResponse,
  database,
  generic;

  factory CLGErrorType.fromCode(String code) {
    for (final value in CLGErrorType.values) {
      if (value.code == code) return value;
    }
    debugPrint('CLGErrorType.fromCode - Error code not found: $code');
    return CLGErrorType.generic;
  }
}
