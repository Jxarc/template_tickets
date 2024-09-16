import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/ui/ui.dart';

class MainProvider extends CLGProvider {
  static MainProvider init() => Injector.appInstance.get<MainProvider>();
  static MainProvider watch(BuildContext context) => context.watch<MainProvider>();
  static MainProvider read(BuildContext context) => context.read<MainProvider>();

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  set isAuthenticated(bool data) {
    _isAuthenticated = data;
    notifyListeners();
  }

  bool _isTermsAccepted = false;
  bool get isTermsAccepted => _isTermsAccepted;
  set isTermsAccepted(bool data) {
    _isTermsAccepted = data;
    notifyListeners();
  }

  bool _isWelcomeShowed = false;
  bool get isWelcomeShowed => _isWelcomeShowed;
  set isWelcomeShowed(bool data) {
    _isWelcomeShowed = data;
    notifyListeners();
  }
}
