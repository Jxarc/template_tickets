import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGNetworkConnection {
  static final CLGNetworkConnection _instance = CLGNetworkConnection._init();
  factory CLGNetworkConnection() => _instance;

  CLGNetworkConnection._init() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  final _streamController = StreamController<bool>.broadcast();
  final _connectivity = Connectivity();
  final Map<String, StreamSubscription> _suscriptions = {};

  ConnectivityResult result = ConnectivityResult.none;
  bool isConnected = false;

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    result = results.lastOrNull ?? ConnectivityResult.none;
    final hasConnection = result != ConnectivityResult.none;
    if (hasConnection != isConnected) {
      isConnected = hasConnection;
      _streamController.add(isConnected);
    }
  }

  void addListener(void Function(bool isConnected) listener) {
    final suscription = _streamController.stream.listen(listener);
    final code = listener.hashCode.toString();
    _suscriptions[code] = suscription;
  }

  void removeListener(void Function(bool isConnected) listener) {
    final code = listener.hashCode.toString();
    final suscription = _suscriptions[code];

    if (suscription != null) {
      suscription.cancel();
      _suscriptions.remove(code);
    }
  }

  void dispose() {
    _streamController.close();
  }

  void showMessage(ScaffoldMessengerState? state) {
    final context = state?.context;
    if (context != null && context.mounted) {
      state?.removeCurrentSnackBar();
      if (isConnected) {
        state?.showSnackBar(CLGToast(
          context,
          text: context.strings.connection_established,
          color: context.theme.primary,
        ));
      } else {
        state?.showSnackBar(CLGSnackbar(
          context,
          text: context.strings.no_internet_connection,
          color: context.theme.magenta,
          neverClose: true,
          textAction: context.strings.accept.toUpperCase(),
          onClick: () => state.removeCurrentSnackBar(),
        ));
      }
    }
  }
}
