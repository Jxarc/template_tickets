import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CompanyManagerSummaryTab extends StatelessWidget {
  const CompanyManagerSummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      color: context.theme.background,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CLGCard(
            padding: EdgeInsets.all(30),
            borderRadius: 20,
            elevation: 0,
            child: CLGImage(
              path: CLGAssets.imgFinishState,
              height: 300,
            ),
          ),
          const SizedBox(height: 10),
          CLGText(
            'Has finalizado tu inscripción con éxito',
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.theme.gray.shade400,
            ),
          ),
          const SizedBox(height: 10),
          CLGText(
            'Ya puedes generar tus boletas',
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.theme.gray.shade400,
            ),
          )
        ],
      ),
    );
  }
}
