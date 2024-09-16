import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class UserDetailProvider extends CLGProvider {
  static UserDetailProvider init() => Injector.appInstance.get<UserDetailProvider>();
  static UserDetailProvider watch(BuildContext context) => context.watch<UserDetailProvider>();
  static UserDetailProvider read(BuildContext context) => context.read<UserDetailProvider>();
}
