import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:provider/provider.dart';

class CLGStates<T> extends StatelessWidget {
  final Function()? onRefresh;
  final Widget? loadingState;
  final Widget? emptyState;
  final bool isScrollControlled;
  final Widget? child;
  final double? stateHeight;
  final double? stateWidth;

  const CLGStates({
    super.key,
    this.loadingState,
    this.emptyState,
    this.onRefresh,
    this.child,
    this.isScrollControlled = false,
    this.stateHeight,
    this.stateWidth,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<T>() as CLGProvider;
    final hasError = CLGErrorState.errors.contains(provider.error?.type);
    final state = hasError ? CLGErrorState(error: provider.error!) : emptyState ?? const _DefaultEmpty();

    return CLGSkeleton(
      isLoading: provider.isLoading,
      skeleton: loadingState ?? const _DefaultLoading(),
      child: CLGState(
        showState: provider.isEmpty,
        onRefresh: onRefresh,
        state: SizedBox(
          height: stateHeight,
          width: stateWidth,
          child: Center(child: state),
        ),
        child: child ?? const SizedBox(),
      ),
    );
  }
}

class _DefaultEmpty extends StatelessWidget {
  const _DefaultEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return CLGEmptyState(
      imagePath: CLGAssets.imgEmptyState1,
      title: context.strings.no_records,
      subtitle: context.strings.no_records_found,
    );
  }
}

class _DefaultLoading extends StatelessWidget {
  const _DefaultLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          12,
          (index) => const CLGRectangleSkeleton(
            marginBottom: 8,
            height: 50,
          ),
        ),
      ),
    );
  }
}
