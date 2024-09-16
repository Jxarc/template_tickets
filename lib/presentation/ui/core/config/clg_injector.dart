import 'package:injector/injector.dart';

abstract class CLGInjector {
  final _i = Injector.appInstance;
  T get<T>() => Injector.appInstance.get();

  CLGInjector() {
    initSources();
    initRepositories();
    initUseCases();
    initProviders();
  }

  void initSources();
  void initRepositories();
  void initUseCases();
  void initProviders();

  void dependency<T>(
    T Function() builder, {
    bool override = false,
    String dependencyName = "",
  }) {
    _i.registerDependency<T>(builder, override: override, dependencyName: dependencyName);
  }

  void singleton<T>(
    T Function() builder, {
    bool override = false,
    String dependencyName = "",
  }) {
    _i.registerSingleton<T>(builder, override: override, dependencyName: dependencyName);
  }
}
