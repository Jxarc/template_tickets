import 'package:template/presentation/ui/ui.dart';

extension CLGErrorTypeCodesExtension on CLGErrorType {
  static const codes = {
    'network': CLGErrorType.networkConnection,
    'server': CLGErrorType.serverConnection,
    'response': CLGErrorType.serverResponse,
    'generic': CLGErrorType.generic,
    'database': CLGErrorType.database,
  };

  String get code {
    for (final key in codes.keys) {
      if (codes[key] == this) return key;
    }
    return '';
  }
}
