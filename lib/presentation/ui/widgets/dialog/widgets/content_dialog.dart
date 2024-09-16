part of '../clg_dialog.dart';

class _CLGContentDialog extends StatelessWidget {
  final Widget? child;
  final double maxHeight;
  final String? description;
  final TextStyle? descriptionStyle;
  final Color? descriptionColor;

  const _CLGContentDialog({
    Key? key,
    required this.maxHeight,
    this.child,
    this.description,
    this.descriptionColor,
    this.descriptionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleDescription = descriptionStyle?.copyWith(
          color: descriptionColor ?? context.theme.dialogDescriptionColor,
        ) ??
        context.textTheme.bodyMedium?.copyWith(
          color: descriptionColor ?? context.theme.dialogDescriptionColor,
        );

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              if (description != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: CLGText(
                      description!,
                      style: styleDescription,
                      textAlign: // TextAlign.left
                          Platform.isAndroid ? TextAlign.start : TextAlign.center,
                    ),
                  ),
                ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
