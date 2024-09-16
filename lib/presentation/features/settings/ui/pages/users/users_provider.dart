import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class UsersProvider extends CLGProvider {
  static UsersProvider init() => Injector.appInstance.get<UsersProvider>();
  static UsersProvider watch(BuildContext context) => context.watch<UsersProvider>();
  static UsersProvider read(BuildContext context) => context.read<UsersProvider>();

  @override
  Future<List<String>> fetchData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return List.generate(10, (e) => e.toString()).toList();
    } catch (e) {}
    return [];
  }
}
