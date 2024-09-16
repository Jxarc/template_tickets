import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:template/presentation/ui/ui.dart';

class CLGTooltip extends StatefulWidget {
  final Duration? waitDuration;
  final double? width;

  final Widget tooltip;
  final Widget child;
  final Color? backgroundColor;
  final double elevation;
  final EdgeInsets? padding;
  final bool showOnTap;

  const CLGTooltip({
    super.key,
    required this.tooltip,
    required this.child,
    this.backgroundColor,
    this.elevation = 1,
    this.width,
    this.padding,
    this.waitDuration,
    this.showOnTap = false,
  });

  @override
  State<CLGTooltip> createState() => _CLGTooltipState();
}

class _CLGTooltipState extends State<CLGTooltip> {
  OverlayEntry? _entry;
  Timer? _timer;

  @override
  void initState() {
    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
    super.initState();
  }

  void _handlePointerEvent(PointerEvent event) {
    if (_entry == null) return;
    if (event is PointerDownEvent) _dismiss();
  }

  @override
  void dispose() {
    _dismiss();
    super.dispose();
  }

  _dismiss() {
    if (_entry != null) {
      _timer?.cancel();
      _entry?.remove();
      _entry = null;
    }
  }

  _show() {
    if (_entry != null) {
      OverlayState? state = Overlay.of(context);
      state.insert(_entry!);
      _timer?.cancel();
      _timer = Timer(widget.waitDuration ?? const Duration(seconds: 4), _dismiss);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () => widget.showOnTap ? _showTooltip(context) : null,
        onLongPress: () => !widget.showOnTap ? _showTooltip(context) : null,
        child: widget.child,
      );
    });
  }

  _showTooltip(BuildContext context) async {
    const spacing = 5;
    _entry = OverlayEntry(builder: (_) {
      final halfScreen = MediaQuery.of(context).size.height / 2;
      final halfWidthScreen = MediaQuery.of(context).size.width / 2;

      final box = context.findRenderObject() as RenderBox;
      final center = box.size.center(box.localToGlobal(Offset.zero));

      final widthTooltip = widget.width ?? MediaQuery.of(context).size.width * 0.6;
      final halfWidthTooltip = widthTooltip / 2;

      final showInLeft = center.dx < halfWidthScreen;
      final showInTop = center.dy > halfScreen;

      var alignLeft = center.dx;
      var alignTop = center.dy;
      var translation = Offset.zero;

      if (showInTop) {
        alignTop = center.dy - box.size.height / 2 - spacing; //up
        translation = const Offset(-0.5, -1); //up
      } else {
        alignTop = center.dy + box.size.height / 2 + spacing; //down
        translation = const Offset(-0.5, 0); //down
      }

      if (showInLeft) {
        final diff = center.dx - halfWidthTooltip;
        if (diff < 0) {
          alignLeft = alignLeft + diff.abs() + spacing;
        }
      } else {
        final diff = halfWidthScreen * 2 - (center.dx + halfWidthTooltip);
        if (diff < 0) {
          alignLeft = alignLeft - diff.abs() - spacing;
        }
      }

      return Stack(
        children: [
          Positioned(
            top: alignTop,
            left: alignLeft,
            child: FractionalTranslation(
              translation: translation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  padding: widget.padding ?? const EdgeInsets.all(10),
                  width: widthTooltip,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? context.theme.primary.shade500,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: widget.elevation != 0
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: widget.elevation,
                              spreadRadius: -widget.elevation * 0.1,
                            )
                          ]
                        : null,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: widget.tooltip,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: alignTop,
            left: center.dx,
            child: FractionalTranslation(
              translation: translation,
              child: Center(
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: 10,
                    height: 10,
                    color: widget.backgroundColor ?? context.theme.primary.shade500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });

    _show();
  }
}
