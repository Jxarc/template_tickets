import 'package:template/presentation/features/settings/ui/pages/company_manager/company_manager_provider.dart';
import 'package:template/presentation/features/settings/ui/pages/user_detail/user_detail_provider.dart';
import 'package:template/presentation/features/settings/ui/pages/user_manager/user_manager_provider.dart';
import 'package:template/presentation/features/settings/ui/pages/users/users_provider.dart';
import 'package:template/presentation/ui/ui.dart';

class SettingsInjector extends CLGInjector {
  @override
  void initProviders() {
    dependency(() => CompanyManagerProvider());
    dependency(() => UsersProvider());
    dependency(() => UserDetailProvider());
    dependency(() => UserManagerProvider());
  }

  @override
  void initRepositories() {
    // TODO: implement initRepositories
  }

  @override
  void initSources() {
    // TODO: implement initSources
  }

  @override
  void initUseCases() {
    // TODO: implement initUseCases
  }
}
