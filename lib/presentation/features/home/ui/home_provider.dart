import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:provider/provider.dart';

class HomeProvider extends CLGProvider {
  HomeProvider() {
    loadPagedData();
  }

  static HomeProvider init() => Injector.appInstance.get<HomeProvider>();
  static HomeProvider watch(BuildContext context) => context.watch<HomeProvider>();
  static HomeProvider read(BuildContext context) => context.read<HomeProvider>();

  @override
  Future<List<String>> fetchPagedData([int page = 0]) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return List.generate(10, (i) => i.toString()).toList();
    } catch (e) {}
    return [];
  }
}
