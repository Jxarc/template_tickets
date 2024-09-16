import 'package:flutter/material.dart';
import 'package:template/presentation/main/main_provider.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/widgets/app_background.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppBackground(
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CLGText(
                    'Bienvenido',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.white,
                    ),
                  ),
                  CLGInputTextForm(
                    title: 'RUT',
                    placeholder: 'Ingresa RUT de usuario',
                    titleColor: context.theme.white,
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'Contraseña',
                    placeholder: 'Ingresa contraseña',
                    titleColor: context.theme.white,
                    type: CLGInputType.password,
                    controller: TextEditingController(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CLGClick(
                      onClick: () {},
                      child: CLGText(
                        'Olvidaste tu contraseña?',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.theme.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            CLGButton(
              text: 'Acceder',
              expandContent: true,
              onClick: () {
                MainProvider.read(context).isAuthenticated = true;
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'No tienes cuenta? ',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.gray.shade400,
                    ),
                  ),
                  TextSpan(
                    text: 'Registrate ahora',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.primary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
