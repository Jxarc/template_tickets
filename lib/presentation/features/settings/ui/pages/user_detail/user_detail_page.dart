import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/features/settings/ui/pages/user_detail/user_detail_provider.dart';
import 'package:template/presentation/features/settings/ui/pages/user_manager/user_manager_page.dart';
import 'package:template/presentation/features/settings/ui/settings_router.dart';
import 'package:template/presentation/ui/ui.dart';

class UserDetailPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(SettingsRouter.userDetail.path);
  }

  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserDetailProvider.init(),
      child: Scaffold(
        appBar: CLGAppBar(
          title: 'Usuario',
          onClickBack: () => context.pop(),
        ),
        body: CLGCard(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const _HeaderInfo(),
              const Expanded(child: _Info()),
              CLGButton(
                width: double.infinity,
                text: 'Enviar comprobante',
                color: context.theme.background.shade700,
                textColor: context.theme.primary,
                borderColor: context.theme.primary,
                borderWidth: 1,
                suffixIcon: CLGIcon(
                  path: CLGIcons.lockOpenAlt,
                  color: context.theme.primary,
                  size: 25,
                ),
                onClick: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  const _HeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CLGAvatar(
          initials: 'CL',
          size: 75,
        ),
        CLGText(
          'Johan Alexander Casanova',
          style: context.textTheme.titleSmall?.copyWith(
            color: context.theme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        CLGText(
          'Administrador',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.theme.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CLGImageButton(
                size: 42,
                borderRadius: 5,
                icon: CLGIcon(
                  path: CLGIcons.trashAlt,
                  color: context.theme.magenta,
                  size: 25,
                ),
                color: context.theme.magenta.shade100,
                onClick: () {},
              ),
              const SizedBox(width: 10),
              CLGImageButton(
                size: 42,
                borderRadius: 5,
                icon: CLGIcon(
                  path: CLGIcons.pen,
                  color: context.theme.primary,
                  size: 25,
                ),
                color: context.theme.primary.shade100,
                onClick: () {
                  UserManagerPage.show(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Item(
            label: 'RUT',
            value: '1234324',
          ),
          _Item(
            label: 'Nombres',
            value: 'Johan Alexaner',
          ),
          _Item(
            label: 'Apellidos',
            value: 'Casanova',
          ),
          _Item(
            label: 'Teléfono',
            value: '+57123434',
          ),
          _Item(
            label: 'Correo',
            value: 'alexandercsanova@gmail.com',
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String label;
  final String value;
  const _Item({
    super.key,
    this.label = '',
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CLGText(
            label,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.gray,
            ),
          ),
          CLGText(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.theme.gray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
