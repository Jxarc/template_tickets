part of '../clg_skeleton.dart';

class CLGCircleSkeleton extends StatelessWidget {
  final double size;
  final Color? color;
  const CLGCircleSkeleton({
    super.key,
    this.size = 50,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
