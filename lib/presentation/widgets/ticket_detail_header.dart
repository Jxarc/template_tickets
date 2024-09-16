import 'package:flutter/cupertino.dart';
import 'package:template/presentation/ui/ui.dart';

class TicketDetailHeader extends StatelessWidget {
  final String value;
  const TicketDetailHeader({
    super.key,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      height: 50,
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: double.infinity,
              child: ColoredBox(
                color: context.theme.primary,
                child: Center(
                  child: CLGText(
                    'Número de la boleta',
                    style: context.textTheme.titleSmall?.copyWith(
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
                value,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
