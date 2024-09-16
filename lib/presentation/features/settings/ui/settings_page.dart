import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/settings/ui/pages/company_manager/company_manager_page.dart';
import 'package:template/presentation/features/settings/ui/pages/users/users_page.dart';
import 'package:template/presentation/features/settings/ui/settings_router.dart';
import 'package:template/presentation/ui/ui.dart';

class SettingsPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(SettingsRouter.settings.path);
  }

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CLGAppBar(
        title: 'Configuración',
        onClickBack: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _BusinessCard(),
            Expanded(child: _OptionsCard()),
          ],
        ),
      ),
    );
  }
}

class _BusinessCard extends StatelessWidget {
  const _BusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CLGCard(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CLGAvatar(),
              const SizedBox(width: 10),
              CLGText(
                'Mi negocio',
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.theme.gray.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionsCard extends StatelessWidget {
  const _OptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      child: Column(
        children: [
          _Item(
            icon: CLGIcons.building,
            name: 'Datos de empresa',
            onClick: () {
              CompanyManagerPage.show(context);
            },
          ),
          Divider(color: context.theme.gray.shade100, height: 0.5),
          _Item(
            icon: CLGIcons.usersAlt,
            name: 'Usuarios',
            onClick: () {
              UsersPage.show(context);
            },
          ),
          Divider(color: context.theme.gray.shade100, height: 0.5),
          _Item(
            icon: CLGIcons.fileCopyAlt,
            name: 'Certificados',
            onClick: () {},
          ),
          Divider(color: context.theme.gray.shade100, height: 0.5),
          _Item(
            icon: CLGIcons.fileInfoAlt,
            name: 'Cafs pedientes',
            onClick: () {},
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String icon;
  final String name;
  final VoidCallback? onClick;
  const _Item({
    super.key,
    this.icon = '',
    this.name = '',
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return CLGClick(
      onClick: onClick,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          CLGIcon(
            path: icon,
            color: context.theme.primary,
            size: 25,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CLGText(
              name,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.theme.primary,
              ),
            ),
          ),
          CLGIcon(
            icon: Icons.arrow_right,
            color: context.theme.gray,
          ),
        ],
      ),
    );
  }
}
