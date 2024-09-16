import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/app_provider.dart';
import 'package:template/presentation/app_router.dart';
import 'package:template/presentation/features/tickets/ui/tickets_page.dart';
import 'package:template/presentation/main/main_page.dart';
import 'package:template/presentation/main/main_provider.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final _router = GoRouter(
    initialLocation: AppRouter.main.path,
    routes: AppRouter.routes,
    observers: [],
    onException: (context, state, router) {
      if (state.uri.toString().contains('#')) {
        final uri = Uri(path: '${state.uri.path}${state.uri.fragment.substring(1)}');
        router.go(uri.toString());
      } else {
        router.go(AppRouter.main.path);
      }
    },
    debugLogDiagnostics: true,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider.init()),
        ChangeNotifierProvider(create: (context) => MainProvider.init()),
      ],
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppProvider.read(context).theme.generate(),
        routerConfig: _router,
      ),
    );
  }
}
