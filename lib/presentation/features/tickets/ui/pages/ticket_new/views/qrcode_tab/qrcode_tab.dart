import 'package:flutter/cupertino.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/widgets/ticket_detail_header.dart';
import 'package:template/presentation/widgets/ticket_detail_qr.dart';

class TicketNewQrcodeTab extends StatelessWidget {
  const TicketNewQrcodeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TicketDetailHeader(
          value: '5',
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TicketDetailQr(),
                CLGInputTextForm(
                  title: 'Email',
                  placeholder: 'Ingresa correo',
                  controller: TextEditingController(),
                ),
                CLGInputTextForm(
                  title: 'Celular',
                  placeholder: 'Ingresa el celular',
                  controller: TextEditingController(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
