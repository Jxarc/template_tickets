import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/ticket_new_page.dart';
import 'package:template/presentation/features/tickets/ui/tickets_provider.dart';
import 'package:template/presentation/features/tickets/ui/tickets_router.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/widgets/ticket_card.dart';

class TicketsPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(TicketsRouter.tickets.path);
  }

  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicketsProvider.init(),
      child: Scaffold(
        appBar: CLGAppBar(
          title: 'Boletas de pago',
          onClickBack: () => context.pop(),
        ),
        floatingActionButton: CLGFloatingActionButton(
          child: CLGIcon(
            path: CLGIcons.qrcodeScan,
            color: context.theme.white,
          ),
          onClick: () => TicketNewPage.show(context),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: _Content(),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CLGInputTextForm(
          controller: TextEditingController(),
          placeholder: 'Buscar boletas',
          prefixIcon: CLGIcon(
            icon: Icons.search,
            color: context.theme.gray,
            size: 25,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return CLGCard(
                child: CLGList<TicketsProvider>(
                  paged: false,
                  stateHeight: constraints.maxHeight * 0.9,
                  emptyState: const _EmptyState(),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return const TicketCard();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CLGEmptyState(
          imagePath: CLGAssets.imgEmptyState1,
          title: 'Aun no tienes boletas generadas',
        ),
        CLGButton(
          width: double.infinity,
          text: 'Nueva boleta',
          suffixIcon: CLGIcon(
            path: CLGIcons.qrcodeScan,
            color: context.theme.white,
            size: 30,
          ),
          onClick: () => TicketNewPage.show(context),
        ),
      ],
    );
  }
}
