import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/settings/ui/pages/company_manager/company_manager_page.dart';
import 'package:template/presentation/features/settings/ui/pages/user_detail/user_detail_page.dart';
import 'package:template/presentation/features/settings/ui/pages/user_manager/user_manager_page.dart';
import 'package:template/presentation/features/settings/ui/pages/users/users_page.dart';
import 'package:template/presentation/features/settings/ui/settings_page.dart';
import 'package:template/presentation/ui/ui.dart';

enum SettingsRouter {
  settings,
  companyDetail,
  companyManager,
  users,
  userDetail,
  userManager;

  String get screen => name.firstUpperCase();
  String get path => '/$name';

  static final routes = [
    GoRoute(
      path: SettingsRouter.settings.path,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: SettingsRouter.companyDetail.path,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: SettingsRouter.companyManager.path,
      builder: (context, state) => const CompanyManagerPage(),
    ),
    GoRoute(
      path: SettingsRouter.users.path,
      builder: (context, state) => const UsersPage(),
    ),
    GoRoute(
      path: SettingsRouter.userDetail.path,
      builder: (context, state) => const UserDetailPage(),
    ),
    GoRoute(
      path: SettingsRouter.userManager.path,
      builder: (context, state) => const UserManagerPage(),
    ),
  ];
}
