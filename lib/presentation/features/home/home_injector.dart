import 'package:template/presentation/features/home/ui/home_provider.dart';
import 'package:template/presentation/ui/ui.dart';

class HomeInjector extends CLGInjector {
  @override
  void initProviders() {
    dependency(() => HomeProvider());
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
}
