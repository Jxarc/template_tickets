import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/ticket_new_provider.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/views/data_tab/data_tab.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/views/qrcode_tab/qrcode_tab.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/views/summary_tab/summary_tab.dart';
import 'package:template/presentation/features/tickets/ui/tickets_router.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketNewPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(TicketsRouter.ticketNew.path);
  }

  const TicketNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicketNewProvider.init(),
      child: Scaffold(
        appBar: CLGAppBar(
          title: 'Nueva boleta',
          onClickBack: () => context.pop(),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: _Content(),
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    TicketNewProvider.read(context).controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: TicketNewProvider.read(context).controller,
            children: const [
              TicketNewDataTab(),
              TicketNewQrcodeTab(),
              TicketNewSummaryTab(),
            ],
          ),
        ),
        const _Action(),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({super.key});

  @override
  Widget build(BuildContext context) {
    if (TicketNewProvider.watch(context).controller == null) return const SizedBox();

    return ListenableBuilder(
      listenable: TicketNewProvider.watch(context).controller!,
      builder: (context, child) {
        return CLGButton(
          width: double.infinity,
          text: _getTextButton(context),
          suffixIcon: _getTextIcon(context),
          onClick: () => _nextPage(context),
        );
      },
    );
  }

  String _getTextButton(BuildContext context) {
    final index = TicketNewProvider.watch(context).controller?.index ?? 0;
    return switch (index) {
      0 => 'Generar boleta',
      1 => 'Enviar',
      _ => 'Finalizar',
    };
  }

  Widget? _getTextIcon(BuildContext context) {
    final index = TicketNewProvider.watch(context).controller?.index ?? 0;
    return switch (index) {
      0 => CLGIcon(
          color: context.theme.white,
          path: CLGIcons.arrowRight,
          size: 25,
        ),
      1 => CLGIcon(
          color: context.theme.white,
          path: CLGIcons.paperPlane,
          size: 25,
        ),
      _ => null,
    };
  }

  void _nextPage(BuildContext context) {
    final index = TicketNewProvider.read(context).controller?.index ?? 0;
    if (index < 2) TicketNewProvider.read(context).controller?.index = index + 1;
    if (index == 2) {
      context.pop();
    }
  }
}
