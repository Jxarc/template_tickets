import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGState extends StatelessWidget {
  final bool showState;

  final Widget? state;
  final Widget child;
  final VoidCallback? onRefresh;

  final Widget? image;
  final String? text;

  const CLGState({
    Key? key,
    required this.child,
    this.showState = false,
    this.onRefresh,
    this.state,
    @Deprecated(
      'Please remove any reference to it. instead of use [state] for build any widget.'
      'This feature was deprecated after v0.20.1.',
    )
    this.image,
    @Deprecated(
      'Please remove any reference to it. instead of use [state] for build any widget.'
      'This feature was deprecated after v0.20.1.',
    )
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preview = text != null
        ? _State(
            image: image ?? state,
            text: text,
            isScrollable: onRefresh != null,
          )
        : _State2(
            image: state ?? image,
            isScrollable: onRefresh != null,
          );

    var newChild = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showState ? preview : child,
    );

    if (onRefresh == null) return newChild;

    return CLGRefreshIndicator(
      color: context.theme.refreshIconColor,
      backgroundColor: context.theme.primary,
      onRefresh: () async {
        onRefresh!();
      },
      child: newChild,
    );
  }
}

class _State extends StatelessWidget {
  final Widget? image;
  final String? text;
  final bool isScrollable;
  const _State({
    Key? key,
    this.image,
    this.text,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) image!,
          if (text != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: CLGText(
                text ?? '',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
              ),
            )
        ],
      ),
    );
    return isScrollable
        ? LayoutBuilder(builder: ((context, constraints) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: constraints.maxHeight * 1.01,
                  child: child,
                )
              ],
            );
          }))
        : child;
  }
}

class _State2 extends StatelessWidget {
  final Widget? image;
  final bool isScrollable;
  const _State2({
    Key? key,
    this.image,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isScrollable
        ? LayoutBuilder(builder: ((context, constraints) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: constraints.maxHeight * 1.01,
                  child: image,
                )
              ],
            );
          }))
        : image ?? const SizedBox();
  }
}
