import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketsProvider extends CLGProvider {
  TicketsProvider() {
    loadPagedData();
  }

  static TicketsProvider init() => Injector.appInstance.get<TicketsProvider>();
  static TicketsProvider watch(BuildContext context) => context.watch<TicketsProvider>();
  static TicketsProvider read(BuildContext context) => context.read<TicketsProvider>();

  @override
  Future<List<String>> fetchPagedData([int page = 0]) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return List.generate(10, (i) => i.toString());
    } catch (e) {}

    return [];
  }
}
