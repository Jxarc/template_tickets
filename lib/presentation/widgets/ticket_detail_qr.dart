import 'package:flutter/cupertino.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketDetailQr extends StatelessWidget {
  const TicketDetailQr({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CLGCard(
          padding: const EdgeInsets.all(20),
          height: constraints.maxWidth,
          child: CLGIcon(
            size: double.infinity,
            path: CLGIcons.qrcodeScan,
            color: context.theme.primary.shade700,
          ),
        );
      },
    );
  }
}
