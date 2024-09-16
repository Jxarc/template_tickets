import 'package:template/presentation/features/tickets/ui/pages/ticket_detail/ticket_detail_provider.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/ticket_new_provider.dart';
import 'package:template/presentation/features/tickets/ui/tickets_provider.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketsInjector extends CLGInjector {
  @override
  void initProviders() {
    dependency(() => TicketsProvider());
    dependency(() => TicketNewProvider());
    dependency(() => TicketDetailProvider());
  }

  @override
  void initRepositories() {
    // TODO: implement initRepositories
  }

  @override
  void initSources() {
    // TODO: implement initSources
  }

  @override
  void initUseCases() {
    // TODO: implement initUseCases
  }
}
