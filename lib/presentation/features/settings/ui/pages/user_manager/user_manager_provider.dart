import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class UserManagerProvider extends CLGProvider {
  static UserManagerProvider init() => Injector.appInstance.get<UserManagerProvider>();
  static UserManagerProvider watch(BuildContext context) => context.watch<UserManagerProvider>();
  static UserManagerProvider read(BuildContext context) => context.read<UserManagerProvider>();
}
