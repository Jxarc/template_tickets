import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_detail/ticket_detail_page.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/ticket_new_page.dart';
import 'package:template/presentation/features/tickets/ui/tickets_page.dart';
import 'package:template/presentation/ui/ui.dart';

enum TicketsRouter {
  tickets,
  ticketNew,
  ticketDetail;

  String get screen => name.firstUpperCase();
  String get path => '/$name';

  static final routes = [
    GoRoute(
      path: TicketsRouter.tickets.path,
      builder: (context, state) => const TicketsPage(),
    ),
    GoRoute(
      path: TicketsRouter.ticketDetail.path,
      builder: (context, state) => const TicketDetailPage(),
    ),
    GoRoute(
      path: TicketsRouter.ticketNew.path,
      builder: (context, state) => const TicketNewPage(),
    ),
  ];
}
