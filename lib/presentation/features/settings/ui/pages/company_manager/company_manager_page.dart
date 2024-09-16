import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/features/settings/ui/pages/company_manager/company_manager_provider.dart';
import 'package:template/presentation/features/settings/ui/pages/company_manager/widgets/company_manager_check_tab.dart';
import 'package:template/presentation/features/settings/ui/pages/company_manager/widgets/company_manager_data_tab.dart';
import 'package:template/presentation/features/settings/ui/pages/company_manager/widgets/company_manager_summary_tab.dart';
import 'package:template/presentation/features/settings/ui/settings_router.dart';
import 'package:template/presentation/ui/ui.dart';

class CompanyManagerPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(SettingsRouter.companyManager.path);
  }

  const CompanyManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CompanyManagerProvider.init(),
      child: Scaffold(
        backgroundColor: context.theme.background.shade700,
        appBar: CLGAppBar(
          title: 'Creación de tu negocio',
        ),
        body: const Column(
          children: [
            Expanded(child: _Content()),
            _Action(),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    CompanyManagerProvider.read(context).controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: CompanyManagerProvider.read(context).controller,
      children: [
        CompanyManagerDataTab(),
        CompanyManagerCheckTab(),
        CompanyManagerSummaryTab(),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({super.key});

  @override
  Widget build(BuildContext context) {
    if (CompanyManagerProvider.watch(context).controller == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
        bottom: 15,
      ),
      child: ListenableBuilder(
        listenable: CompanyManagerProvider.watch(context).controller!,
        builder: (context, child) => CLGButton(
          width: double.infinity,
          onClick: () => _nextPage(context),
          text: _getTextButton(context),
          suffixIcon: _getTextIcon(context),
        ),
      ),
    );
  }

  String _getTextButton(BuildContext context) {
    final index = CompanyManagerProvider.watch(context).controller?.index ?? 0;
    return switch (index) {
      0 => 'Siguiente',
      1 => 'Finalizar',
      _ => 'Crear usuario Administrador',
    };
  }

  Widget? _getTextIcon(BuildContext context) {
    final index = CompanyManagerProvider.watch(context).controller?.index ?? 0;
    return switch (index) {
      0 => CLGIcon(
          color: context.theme.white,
          path: CLGIcons.arrowRight,
          size: 25,
        ),
      _ => null,
    };
  }

  void _nextPage(BuildContext context) {
    final index = CompanyManagerProvider.read(context).controller?.index ?? 0;
    if (index < 2) CompanyManagerProvider.read(context).controller?.index = index + 1;
    if (index == 2) {
      context.pop();
    }
  }
}
