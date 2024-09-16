import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/presentation/app_provider.dart';
import 'package:template/presentation/features/home/ui/home_page.dart';
import 'package:template/presentation/features/settings/ui/settings_page.dart';
import 'package:template/presentation/main/main_provider.dart';
import 'package:template/presentation/main/views/terms.dart';
import 'package:template/presentation/main/views/welcome.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/features/login/ui/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = AppProvider.watch(context).theme.packageTheme.brightness;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: context.theme.primary,
        statusBarIconBrightness: brightness,
        statusBarBrightness: brightness,
        systemNavigationBarIconBrightness: brightness,
      ),
      child: getView(context),
    );
  }

  Widget getView(BuildContext context) {
    final isAuthenticated = MainProvider.watch(context).isAuthenticated;
    final isWelcomeShowed = MainProvider.watch(context).isWelcomeShowed;
    final isTermsAccepted = MainProvider.watch(context).isTermsAccepted;

    if (isAuthenticated) {
      if (!isWelcomeShowed) return const Welcome();
      if (!isTermsAccepted) return const Terms();
      return const HomePage();
    }
    return const LoginPage();
  }
}
