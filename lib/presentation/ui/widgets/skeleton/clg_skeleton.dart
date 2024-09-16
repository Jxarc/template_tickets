import 'dart:math';

import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

part 'widgets/clg_card_skeleton.dart';
part 'widgets/clg_circle_skeleton.dart';
part 'widgets/clg_rectangle_skeleton.dart';

class CLGSkeleton extends StatelessWidget {
  final bool isLoading;
  final Widget skeleton;
  final Widget child;
  final Color? color;
  final bool disabledAnimation;

  const CLGSkeleton({
    Key? key,
    required this.child,
    required this.skeleton,
    this.isLoading = false,
    this.disabledAnimation = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (disabledAnimation) {
      return isLoading ? _CLGSkeleton(child: skeleton) : child;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading ? _CLGSkeleton(child: skeleton) : child,
    );
  }
}

class _CLGSkeleton extends StatefulWidget {
  final Widget child;
  const _CLGSkeleton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<_CLGSkeleton> createState() => _CLGSkeletonState();
}

class _CLGSkeletonState extends State<_CLGSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController.unbounded(
      vsync: this,
    )..repeat(min: -2, max: 2, period: const Duration(milliseconds: 1000));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: widget.child,
        builder: (_, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  context.theme.gray.shade100.withOpacity(0.8),
                  context.theme.gray.shade200.withOpacity(0.5),
                  context.theme.gray.shade100.withOpacity(0.8),
                ],
                stops: const [0.1, 0.5, 1],
                begin: const Alignment(-2.4, -0.2),
                end: const Alignment(2.4, 0.2),
                tileMode: TileMode.clamp,
                transform: _SlidingGradientTransform(controller.value),
              ).createShader(bounds);
            },
            child: child,
          );
        });
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform(this.slidePercent);
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

double randomSize(start, end) {
  final diff = end - start;
  return start + Random().nextDouble() * diff;
}
