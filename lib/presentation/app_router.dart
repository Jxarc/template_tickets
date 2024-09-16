import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/settings/ui/settings_router.dart';
import 'package:template/presentation/features/tickets/ui/tickets_router.dart';
import 'package:template/presentation/main/main_page.dart';
import 'package:template/presentation/ui/ui.dart';

enum AppRouter {
  main,
  tickets,
  settings;

  String get screen => name.firstUpperCase();
  String get path => '/$name';

  static final routes = [
    GoRoute(
      path: AppRouter.main.path,
      builder: (context, state) => const MainPage(),
    ),
    ...TicketsRouter.routes,
    ...SettingsRouter.routes,
  ];
}
