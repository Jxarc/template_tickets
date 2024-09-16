import 'package:flutter/cupertino.dart';

class CLGAdaptiveList extends StatelessWidget {
  final double maxHeight;
  final double spacing;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const CLGAdaptiveList({
    super.key,
    required this.maxHeight,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            itemCount,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: index < (itemCount - 1) ? spacing : 0),
              child: itemBuilder(context, index),
            ),
          ),
        ),
      ),
    );
  }
}
