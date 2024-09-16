part of '../clg_skeleton.dart';

class CLGCardSkeleton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const CLGCardSkeleton(
    this.child, {
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xfffafafa), width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
