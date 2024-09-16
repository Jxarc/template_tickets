import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketNewProvider extends CLGProvider {
  static TicketNewProvider init() => Injector.appInstance.get<TicketNewProvider>();
  static TicketNewProvider watch(BuildContext context) => context.watch<TicketNewProvider>();
  static TicketNewProvider read(BuildContext context) => context.read<TicketNewProvider>();

  TabController? controller;
}
