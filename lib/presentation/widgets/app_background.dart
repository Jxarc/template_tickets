import 'package:flutter/widgets.dart';
import 'package:template/presentation/ui/ui.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;
  final double? height;
  const AppBackground({
    super.key,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBackgroundClipper(),
          child: Container(
            height: height ?? MediaQuery.of(context).size.height * 0.8,
            color: context.theme.primary,
          ),
        ),
        child ?? const SizedBox(),
      ],
    );
  }
}

class AppBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final maxHeight = size.height;
    final maxWidth = size.width;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, maxHeight * 0.8);
    path.quadraticBezierTo(maxWidth * 0.08, maxHeight * 0.79, maxWidth * 0.18, maxHeight * 0.85);
    path.quadraticBezierTo(maxWidth * 0.6, maxHeight * 1.1, maxWidth, maxHeight * 0.85);

    path.lineTo(maxWidth, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
