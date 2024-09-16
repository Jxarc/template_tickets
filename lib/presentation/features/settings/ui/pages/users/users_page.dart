import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/features/settings/ui/pages/user_detail/user_detail_page.dart';
import 'package:template/presentation/features/settings/ui/pages/user_manager/user_manager_page.dart';
import 'package:template/presentation/features/settings/ui/pages/users/users_provider.dart';
import 'package:template/presentation/features/settings/ui/settings_router.dart';
import 'package:template/presentation/ui/ui.dart';

class UsersPage extends StatelessWidget {
  static Future<bool?> show(BuildContext context) {
    return context.push(SettingsRouter.users.path);
  }

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsersProvider.init()..loadData(),
      child: Scaffold(
        appBar: CLGAppBar(
          title: 'Usuarios',
          onClickBack: () => context.pop(),
        ),
        body: CLGCard(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 2,
          ),
          child: CLGList<UsersProvider>(
            itemBuilder: (context, index) => _UserCard(),
          ),
        ),
        floatingActionButton: CLGFloatingActionButton(
          child: CLGIcon(
            path: CLGIcons.plus,
            color: context.theme.white,
            size: 25,
          ),
          onClick: () {
            UserManagerPage.show(context);
          },
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CLGClick(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          onClick: () {
            UserDetailPage.show(context);
          },
          child: Row(
            children: [
              CLGAvatar(
                size: 45,
                initials: 'AS',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CLGText(
                        'Johan Alexander Casanova',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.theme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CLGText(
                        'Administrador',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.theme.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CLGIcon(
                path: CLGIcons.angleRight,
                color: context.theme.primary,
                size: 25,
              ),
            ],
          ),
        ),
        Divider(
          height: 0.5,
          color: context.theme.gray.shade100,
        ),
      ],
    );
  }
}
