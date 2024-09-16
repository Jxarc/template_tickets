import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class CompanyManagerProvider extends CLGProvider {
  static CompanyManagerProvider init() => Injector.appInstance.get<CompanyManagerProvider>();
  static CompanyManagerProvider watch(BuildContext context) => context.watch<CompanyManagerProvider>();
  static CompanyManagerProvider read(BuildContext context) => context.read<CompanyManagerProvider>();

  TabController? controller;
}
