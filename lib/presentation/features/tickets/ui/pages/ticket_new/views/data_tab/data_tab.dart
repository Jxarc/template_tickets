import 'package:flutter/cupertino.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketNewDataTab extends StatelessWidget {
  const TicketNewDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          const _FormHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CLGInputTextForm(
                    title: 'Valor (*)',
                    placeholder: 'Ingresa el valor',
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'Concepto',
                    placeholder: 'Ingresa concepto de la boleta',
                    controller: TextEditingController(),
                  ),
                  CLGInputTextForm(
                    title: 'Descripción',
                    placeholder: 'Ingresa alguna descripción',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      elevation: 0,
      color: context.theme.primary.shade300,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CLGCard(
            elevation: 0,
            height: 50,
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: double.infinity,
                    child: ColoredBox(
                      color: context.theme.primary,
                      child: Center(
                        child: CLGText(
                          'Número de boleta',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.theme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CLGText(
                      '5',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.theme.gray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: _RadioItem(
                  index: 0,
                  selected: 0,
                  title: 'Afecta',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _RadioItem(
                  index: 0,
                  selected: 1,
                  title: 'Excenta',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadioItem extends StatelessWidget {
  final int index;
  final int selected;
  final String title;
  const _RadioItem({
    super.key,
    this.index = 0,
    this.selected = -1,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          CLGRadio(
            value: index,
            groupValue: selected,
            onChanged: (value) {},
          ),
          const SizedBox(width: 15),
          CLGText(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.black,
            ),
          ),
        ],
      ),
    );
  }
}
