import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/presentation/features/login/ui/views/login_tab/login_tab.dart';
import 'package:template/presentation/features/login/ui/views/signup_tab/signup_tab.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late final _controller = TabController(length: 3, vsync: this, initialIndex: 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: [
          _InitPage(),
          LoginTab(),
          SignupTab(),
        ],
      ),
    );
  }
}

class _InitPage extends StatelessWidget {
  const _InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
