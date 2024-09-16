import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/settings/ui/pages/user_manager/user_manager_provider.dart';
import 'package:template/presentation/features/settings/ui/settings_router.dart';
import 'package:template/presentation/ui/ui.dart';

class UserManagerPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(SettingsRouter.userManager.path);
  }

  const UserManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManagerProvider.init(),
      child: Scaffold(
        appBar: CLGAppBar(
          title: 'Nuevo usuario',
          onClickBack: () => context.pop(),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(child: _Content()),
              SizedBox(height: 15),
              _Action(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGButton(
      text: 'Crear usuario',
      width: double.infinity,
      suffixIcon: CLGIcon(
        path: CLGIcons.arrowRight,
        color: context.theme.white,
      ),
      onClick: () {},
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CLGAvatar(
              path: 'https://cdn-icons-png.flaticon.com/512/147/147131.png',
              size: 90,
              indicator: CLGClick(
                backgroundColor: context.theme.primary,
                padding: const EdgeInsets.all(6),
                borderRadius: BorderRadius.circular(5),
                onClick: () {},
                child: CLGIcon(
                  path: CLGIcons.pen,
                  color: context.theme.white,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CLGInputDropdownForm(
                      title: 'Rol',
                      placeholder: 'Administrador',
                      selected: '1',
                      options: [
                        CLGInputDropdownFormOption('1', 'Administrador'),
                      ],
                      onChanged: (val) {},
                    ),
                    CLGInputTextForm(
                      title: 'Rol',
                      placeholder: 'Administrador',
                      controller: TextEditingController(),
                    ),
                    CLGInputTextForm(
                      title: 'RUT',
                      requiredText: ' (*)',
                      placeholder: 'Ingresar RUT',
                      controller: TextEditingController(),
                    ),
                    CLGInputTextForm(
                      title: 'Nombres',
                      requiredText: ' (*)',
                      placeholder: 'Ingresar nombres',
                      controller: TextEditingController(),
                    ),
                    CLGInputTextForm(
                      title: 'Apellidos',
                      requiredText: ' (*)',
                      placeholder: 'Ingresar apellidos',
                      controller: TextEditingController(),
                    ),
                    CLGInputTextForm(
                      title: 'Teléfono',
                      requiredText: ' (*)',
                      placeholder: 'Ingresar el valor',
                      controller: TextEditingController(),
                    ),
                    CLGInputTextForm(
                      title: 'Correo',
                      requiredText: ' (*)',
                      placeholder: 'Ingresar el correo',
                      controller: TextEditingController(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
