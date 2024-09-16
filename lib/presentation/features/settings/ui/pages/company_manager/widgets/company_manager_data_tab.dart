import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CompanyManagerDataTab extends StatelessWidget {
  const CompanyManagerDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CLGAvatar(
            path: CLGIcons.qrcodeScan,
            size: 65,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CLGInputTextForm(
                    title: 'Razón social',
                    placeholder: 'Ingresa la razón social',
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'RUT',
                    placeholder: 'Ingresar RUT',
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'Teléfono',
                    placeholder: 'Ingresar teléfono',
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'Dirección',
                    placeholder: 'Ingresar dirección',
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'Direccion',
                    placeholder: 'Ingresar comuna',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
