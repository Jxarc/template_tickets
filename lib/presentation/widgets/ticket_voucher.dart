import 'package:flutter/cupertino.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketVoucher extends StatelessWidget {
  const TicketVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      elevation: 0,
      child: Center(
        child: CLGText(
          'Vaucher',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.gray,
          ),
        ),
      ),
    );
  }
}
