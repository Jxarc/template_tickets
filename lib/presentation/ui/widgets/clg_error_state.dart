import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGErrorState extends StatelessWidget {
  static final errors = [
    CLGErrorType.database,
    CLGErrorType.serverConnection,
    CLGErrorType.serverResponse,
    CLGErrorType.networkConnection,
    CLGErrorType.generic,
  ];

  final CLGError error;
  final String? imagePath;
  final double imageScale;
  final Function()? onRefresh;

  const CLGErrorState({
    super.key,
    required this.error,
    this.imagePath,
    this.imageScale = 1,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final color = getColor(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CLGEmptyState(
          title: getTitle(context),
          subtitle: getDescription(context),
          titleColor: color,
          imagePath: validImagePath,
          imageScale: imageScale,
        ),
        Visibility(
          visible: onRefresh != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CLGButton(
              text: getTextButton(context),
              onClick: onRefresh,
              color: color,
              height: 45,
              elevation: 0,
              expandContent: true,
            ),
          ),
        )
      ],
    );
  }

  String getTextButton(BuildContext context) {
    if (error.type == CLGErrorType.networkConnection) return context.strings.update;
    return context.strings.retry;
  }

  String get validImagePath {
    if (imagePath != null) return imagePath ?? '';
    return switch (error.type) {
      CLGErrorType.database => CLGAssets.imgErrorDatabase,
      CLGErrorType.serverConnection => CLGAssets.imgErrorServer,
      CLGErrorType.serverResponse => CLGAssets.imgErrorServer,
      CLGErrorType.networkConnection => CLGAssets.imgErrorConnection,
      _ => CLGAssets.imgErrorGeneric,
    };
  }

  String getTitle(BuildContext context) {
    return switch (error.type) {
      CLGErrorType.database => context.strings.we_sorry_no_access_to_database,
      CLGErrorType.serverConnection => context.strings.server_no_response,
      CLGErrorType.serverResponse => context.strings.error_server_response,
      CLGErrorType.networkConnection => context.strings.error_connection,
      CLGErrorType.generic => context.strings.we_sorry,
      _ => error.type.code,
    };
  }

  String getDescription(BuildContext context) {
    return switch (error.type) {
      CLGErrorType.database => context.strings.in_this_moment_you_can_access_to_database_try_later,
      CLGErrorType.serverConnection => context.strings.in_this_moment_app_can_not_connect_with_server_try_later,
      CLGErrorType.serverResponse => context.strings.server_sent_a_incorrect_response_try_again,
      CLGErrorType.networkConnection => context.strings.please_check_your_connection_network_try_with_other_network,
      CLGErrorType.generic => context.strings.we_are_working_to_app_works_back,
      _ => error.description,
    };
  }

  Color getColor(BuildContext context) {
    return switch (error.type) {
      CLGErrorType.database => context.theme.magenta,
      CLGErrorType.serverConnection => context.theme.magenta,
      CLGErrorType.serverResponse => context.theme.magenta,
      CLGErrorType.networkConnection => context.theme.magenta,
      CLGErrorType.generic => context.theme.magenta,
      _ => context.theme.primary,
    };
  }
}
