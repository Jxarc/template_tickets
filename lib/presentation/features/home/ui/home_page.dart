import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/presentation/features/home/ui/home_provider.dart';
import 'package:template/presentation/features/settings/ui/settings_page.dart';
import 'package:template/presentation/features/tickets/ui/pages/ticket_new/ticket_new_page.dart';
import 'package:template/presentation/features/tickets/ui/tickets_page.dart';
import 'package:template/presentation/main/main_provider.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:template/presentation/widgets/ticket_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider.init(),
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                _UserCard(),
                _StatisticsCard(),
                Expanded(
                  child: _TicketsCard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CLGCard(
        elevation: 1,
        child: CLGClick(
          onClick: () {},
          child: Row(
            children: [
              const SizedBox(width: 10),
              CLGAvatar(
                path: 'https://cdn-icons-png.flaticon.com/512/147/147131.png',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CLGText(
                        'Carlos Mazuera',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.theme.primary,
                        ),
                      ),
                      CLGText(
                        'Administrador',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.theme.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CLGPopupMenu(
                children: [
                  CLGPopupMenuItem(
                    prefixIcon: CLGIcons.cog,
                    label: 'Configuraciones',
                    onClick: () => SettingsPage.show(context),
                  ),
                  CLGPopupMenuItem(
                    prefixIcon: CLGIcons.sync,
                    label: 'Cambiar empresa',
                    onClick: () => _changeAccount(context),
                  ),
                  CLGPopupMenuItem(
                    prefixIcon: CLGIcons.logOut,
                    label: 'Cerrar sessión',
                    onClick: () {
                      MainProvider.read(context).isAuthenticated = false;
                    },
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CLGAvatar(
                        path: 'https://cdn-icons-png.flaticon.com/512/147/147131.png',
                      ),
                      CLGIcon(
                        icon: Icons.arrow_drop_down,
                        color: context.theme.black,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _changeAccount(BuildContext context) {
    final results = CLGSelect.show(
      context,
      initialValues: [0],
      isConfirm: true,
      buttonText: 'Cambiar de empresa',
      buttonIcon: CLGIcon(
        icon: Icons.sync,
        color: context.theme.white,
        size: 20,
      ),
      children: List.generate(
        3,
        (i) => CLGSelectOption(
          title: 'Mi negocio $i',
          prefix: CLGAvatar(
            size: 30,
            path: 'https://cdn-icons-png.flaticon.com/512/147/147131.png',
          ),
        ),
      ),
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  const _StatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CLGCard(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CLGAvatar(
                    size: 30,
                    path: 'https://cdn-icons-png.flaticon.com/512/147/147131.png',
                  ),
                  const SizedBox(width: 10),
                  CLGText('Mi negocio 1'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _StatisticItem(
                      value: '\$0',
                      title: 'Total generado',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatisticItem(
                      value: '0',
                      title: 'Boletas generadas',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatisticItem extends StatelessWidget {
  final String title;
  final String value;
  const _StatisticItem({
    super.key,
    this.title = '',
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return CLGCard(
      elevation: 1,
      color: context.theme.gray.shade100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CLGText(
              value,
              style: context.textTheme.headlineLarge?.copyWith(
                color: context.theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            CLGText(
              title,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.theme.gray.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketsCard extends StatelessWidget {
  const _TicketsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CLGText(
                'Últimas boletas generadas',
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CLGButton(
              text: 'Ver todas',
              textColor: context.theme.primary,
              color: context.theme.background.shade700,
              borderRadius: BorderRadius.circular(20),
              onClick: () => TicketsPage.show(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CLGCard(
            elevation: 1,
            child: LayoutBuilder(builder: (context, constraints) {
              return CLGList<HomeProvider>(
                paged: false,
                stateHeight: constraints.maxHeight * .9,
                padding: const EdgeInsets.all(10),
                emptyState: const _EmptyState(),
                itemBuilder: (context, index) {
                  return TicketCard();
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CLGEmptyState(
            imagePath: CLGAssets.imgEmptyState2,
            title: 'Aun no tienes boletas generadas',
          ),
          CLGButton(
            width: double.infinity,
            text: 'Nueva boleta',
            suffixIcon: CLGIcon(
              path: CLGIcons.qrcodeScan,
              color: context.theme.white,
              size: 30,
            ),
            onClick: () => TicketNewPage.show(context),
          ),
        ],
      ),
    );
  }
}
