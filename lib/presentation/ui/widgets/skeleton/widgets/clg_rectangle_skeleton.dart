part of '../clg_skeleton.dart';

class CLGRectangleSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double marginBottom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;

  const CLGRectangleSkeleton({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.marginBottom = 0,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        bottom: marginBottom,
        left: marginLeft,
        right: marginRight,
      ),
      height: height ?? 10,
      width: width,
      decoration: BoxDecoration(
        color: context.theme.gray.shade100,
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
