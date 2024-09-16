import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/tickets/ui/tickets_router.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/widgets/ticket_detail_header.dart';
import 'package:template/presentation/widgets/ticket_detail_qr.dart';

class TicketDetailPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(TicketsRouter.ticketDetail.path);
  }

  const TicketDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CLGAppBar(
        title: 'Detalle boleta',
        onClickBack: () => context.pop(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TicketDetailHeader(
          value: '5',
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              _Details(),
              TicketDetailQr(),
            ],
          ),
        )),
        _Action(),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CLGText(
                  'Detalle de boleta',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.theme.gray.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CLGCard(
                elevation: 0,
                borderColor: context.theme.gray.shade300,
                borderWidth: 1,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: CLGText(
                  'Excenta'.toUpperCase(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          CLGCard(
            margin: const EdgeInsets.only(bottom: 10),
            color: context.theme.primary.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: CLGText(
                    'Valor',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.black,
                    ),
                  ),
                ),
                CLGText(
                  '\$45.000',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: _DetailItem(
                  title: 'Concepto',
                  value: '10 Zapatos rayas rojas',
                ),
              ),
              Expanded(
                child: _DetailItem(
                  title: 'Fecha',
                  value: '10/10/2024',
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              Expanded(
                child: _DetailItem(
                  title: 'Descripción',
                  value: '10 Zapatos rayas rojas',
                ),
              ),
              Expanded(child: _DetailItem()),
            ],
          )
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String title;
  final String value;
  const _DetailItem({
    super.key,
    this.title = '',
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    if (title.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CLGText(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.gray,
          ),
        ),
        CLGText(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.black,
          ),
        )
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGButton(
      width: double.infinity,
      text: 'Ver boleta generada',
      onClick: () {},
    );
  }
}
