import 'package:injector/injector.dart';
import 'package:template/presentation/app_provider.dart';
import 'package:template/presentation/features/home/home_injector.dart';
import 'package:template/presentation/features/settings/settings_injector.dart';
import 'package:template/presentation/features/tickets/tickets_injector.dart';
import 'package:template/presentation/main/main_provider.dart';
import 'package:template/presentation/ui/ui.dart';

class AppInjector extends CLGInjector {
  @override
  void initProviders() {
    dependency(() => AppProvider());
    dependency(() => MainProvider());
  }

  @override
  void initRepositories() {
    // TODO: implement initRepositories
  }

  @override
  void initSources() {
    // TODO: implement initServices
  }

  @override
  void initUseCases() {
    // TODO: implement initUsecases
  }

  static void initInjectors() => [
        AppInjector(),
        HomeInjector(),
        TicketsInjector(),
        SettingsInjector(),
      ];
}
