import 'package:flutter/cupertino.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/widgets/ticket_voucher.dart';

class TicketNewSummaryTab extends StatelessWidget {
  const TicketNewSummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      margin: const EdgeInsets.only(bottom: 15),
      child: TicketVoucher(),
    );
  }
}
