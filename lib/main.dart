import 'package:flutter/material.dart';
import 'package:template/core/app_injector.dart';
import 'package:template/presentation/app_page.dart';

void main() async {
  await _initialize();
  runApp(const AppPage());
}

Future<void> _initialize() async {
  AppInjector.initInjectors();
}
