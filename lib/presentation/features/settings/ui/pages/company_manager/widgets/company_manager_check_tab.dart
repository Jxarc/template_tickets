import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CompanyManagerCheckTab extends StatelessWidget {
  const CompanyManagerCheckTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CLGCard(
          color: context.theme.background,
          elevation: 0,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: CLGText(
            'Identificate con el servicio de impuestos interos mediante tu clave tributaria.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.black,
            ),
          ),
        ),
        Expanded(
          child: CLGCard(
            color: context.theme.colegiumBlue,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            elevation: 0,
            width: double.infinity,
            child: Column(
              children: [
                CLGText(
                  'ClaveÚnica',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: context.theme.white,
                  ),
                ),
                Expanded(
                  child: CLGCard(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CLGInputTextForm(
                            title: 'RUNT',
                            placeholder: 'Ingregar RUT',
                            controller: TextEditingController(),
                          ),
                          CLGInputTextForm(
                            title: 'Ingresar Clave Única',
                            placeholder: 'Ingregar RUT',
                            controller: TextEditingController(),
                          ),
                          const SizedBox(height: 10),
                          CLGButton(
                            text: 'Ingresar',
                            width: double.infinity,
                            color: context.theme.colegiumBlue,
                            onClick: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
