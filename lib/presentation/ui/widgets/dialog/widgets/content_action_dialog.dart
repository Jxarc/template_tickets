part of '../clg_dialog.dart';

class _CLGContentActions extends StatelessWidget {
  final List<CLGActionDialog> actions;
  final double maxHeight;
  const _CLGContentActions({
    Key? key,
    required this.maxHeight,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = Platform.isAndroid ? const EdgeInsets.only(right: 10, bottom: 10, left: 10) : EdgeInsets.zero;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Container(
        width: double.infinity,
        padding: padding,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _LayoutActions(actions: actions),
        ),
      ),
    );
  }
}

class _LayoutActions extends StatelessWidget {
  final List<CLGActionDialog> actions;
  const _LayoutActions({Key? key, this.actions = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (actions.length > 2)
          Column(
            children: List.generate(
              actions.length,
              (index) => _Action(
                extend: true,
                onClick: () => actions[index].onClick(),
                text: actions[index].title,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        if (Platform.isAndroid && actions.length <= 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              actions.length,
              (index) => _Action(
                text: actions[index].title,
                onClick: () => actions[index].onClick(),
              ),
            ),
          ),
        if (Platform.isIOS && actions.length <= 2)
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
              child: _Action(
                extend: true,
                text: actions[0].title,
                onClick: () => actions[0].onClick(),
              ),
            ),
            Container(
              color: context.theme.disabledColor,
              height: 45,
              width: 0.5,
            ),
            if (actions.length > 1)
              Expanded(
                child: _Action(
                  extend: true,
                  text: actions[1].title,
                  onClick: () => actions[1].onClick(),
                ),
              )
          ]),
      ],
    );
  }
}
