import 'package:flutter/material.dart';
import 'package:template/presentation/main/main_provider.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/widgets/app_background.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        height: MediaQuery.of(context).size.height * 0.85,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CLGText(
                          'Bienvenido a C-Factura',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.theme.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CLGText(
                          '''
Para empezar, lo único que necesitas es registrar tu negocio con nosotros. Es un proceso rápido y sencillo que abrirá un mundo de oportunidades. 

Haga clic en "Comenzar" y dé el primer paso hacia el éxito de su negocio. ¡Estamos aquí para apoyarle en cada etapa del camino!
''',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.theme.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CLGImage(
                            path: CLGAssets.imgPhoneCheck,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CLGButton(
                  text: 'Acceder',
                  expandContent: true,
                  onClick: () {
                    MainProvider.read(context).isWelcomeShowed = true;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
