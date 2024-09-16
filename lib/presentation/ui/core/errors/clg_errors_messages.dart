import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/widgets.dart';

extension CLGErrorTypeMessagesExtension on CLGErrorType {
  String getMessage(BuildContext context) {
    switch (this) {
      case CLGErrorType.serverConnection:
        return context.strings.connection_problems_you_try_again_later;
      case CLGErrorType.serverResponse:
        return context.strings.server_sent_a_incorrect_response_try_again;
      case CLGErrorType.networkConnection:
        return context.strings.need_internet_connection;

      case CLGErrorType.database:
      case CLGErrorType.generic:
        debugPrint('No translate to code: $code');
        return '';
    }
  }
}
