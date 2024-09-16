import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_detail/ticket_detail_page.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGClick(
      onClick: () {
        TicketDetailPage.show(context);
      },
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CLGText(
                  '10 Zapatos rayas rojas',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.theme.gray.shade400,
                  ),
                ),
                const _TicketLabel(
                  icon: CLGIcons.calendarAlt,
                  text: '\$45.000',
                ),
                const _TicketLabel(
                  icon: CLGIcons.user,
                  text: 'Carlos Mazuera',
                )
              ],
            ),
          ),
          CLGText(
            '\$45.000',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          CLGIcon(
            path: CLGIcons.angleRight,
          ),
        ],
      ),
    );
  }
}

class _TicketLabel extends StatelessWidget {
  final String icon;
  final String text;
  const _TicketLabel({
    super.key,
    this.icon = '',
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CLGIcon(
          path: icon,
          color: context.theme.gray,
          size: 16,
        ),
        const SizedBox(width: 4),
        CLGText(
          text,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.theme.gray,
          ),
        ),
      ],
    );
  }
}
