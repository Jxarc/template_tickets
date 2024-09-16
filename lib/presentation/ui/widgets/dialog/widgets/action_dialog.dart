part of '../clg_dialog.dart';

class _Action extends StatelessWidget {
  final bool extend;
  final String text;
  final Function onClick;
  final BorderRadius? borderRadius;

  const _Action({
    Key? key,
    required this.text,
    required this.onClick,
    this.borderRadius,
    this.extend = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleButton = context.textTheme.bodyMedium?.copyWith(
      color: context.theme.primary,
      fontWeight: FontWeight.w600,
    );

    if (Platform.isIOS) {
      return Column(
        children: [
          Container(
            color: context.theme.disabledColor,
            height: 0.5,
          ),
          CLGButton(
            width: extend ? double.infinity : null,
            height: 45,
            onClick: () => onClick(),
            text: text,
            color: context.theme.dialogBackgroundColor,
            style: styleButton,
            textColor: context.theme.primary,
            elevation: 0,
            borderRadius: borderRadius ?? BorderRadius.zero,
          )
        ],
      );
    }

    var child = CLGButton(
      width: extend ? double.infinity : null,
      height: 35,
      onClick: () => onClick(),
      text: text,
      textAlign: Alignment.centerRight,
      color: context.theme.dialogBackgroundColor,
      style: styleButton,
      textColor: context.theme.primary,
      elevation: 0,
      borderRadius: borderRadius ?? BorderRadius.circular(50),
    );

    return child;
  }
}
