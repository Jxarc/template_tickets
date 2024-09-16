part of '../clg_list.dart';

class CLGListTile extends StatelessWidget {
  final bool checkEnabled;
  final bool checkVisible;
  final bool clickEnabled;
  final bool suffixIconVisible;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Color? backgroundCheckColor;
  final Color? rippleColor;
  final Widget? child;
  final double elevation;
  final double borderRadius;

  const CLGListTile({
    super.key,
    this.checkEnabled = false,
    this.checkVisible = true,
    this.clickEnabled = false,
    this.suffixIconVisible = true,
    this.suffixIcon,
    this.prefixIcon,
    this.elevation = 0,
    this.borderRadius = 0,
    this.backgroundColor,
    this.backgroundCheckColor,
    this.rippleColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? const SizedBox();
  }
}

class _ListTile<T> extends StatefulWidget {
  final CLGPagingController<T> controller;
  final CLGListItemCheck? itemCheck;
  final CLGListItemClick? itemClick;
  final CLGListTile? child;
  final int index;
  const _ListTile({
    super.key,
    required this.controller,
    this.itemCheck,
    this.itemClick,
    this.index = 0,
    this.child,
  });

  @override
  State<_ListTile<T>> createState() => _ListTileState<T>();
}

class _ListTileState<T> extends State<_ListTile<T>> {
  double _prefixWidth = 15;
  @override
  Widget build(BuildContext context) {
    final state = widget.controller.selecteds.contains(widget.index);
    final checkColor = widget.child?.backgroundCheckColor ?? context.theme.primary.shade100;
    final color = widget.child?.backgroundColor ?? context.theme.background;

    final clickEnabled = (widget.controller.selecteds.isNotEmpty && (widget.child?.checkEnabled ?? false)) || (widget.child?.clickEnabled ?? false);
    final checkVisible = widget.controller.selectedMode && (widget.child?.checkVisible ?? false);
    return CLGCard(
      color: state ? checkColor : color,
      elevation: widget.child?.elevation ?? 0,
      borderRadius: widget.child?.borderRadius ?? 0,
      child: Stack(
        children: [
          CLGClick(
            padding: EdgeInsets.only(
              left: checkVisible ? _prefixWidth : _prefixWidth + 10,
              right: 5,
            ),
            rippleColor: widget.child?.rippleColor,
            onClick: clickEnabled ? () => _clickItem(context, !state) : null,
            onLongPress: clickEnabled ? () => _checkItem(context, true) : null,
            child: Row(
              children: [
                Expanded(child: widget.child ?? const SizedBox()),
                Visibility(
                  visible: widget.child?.suffixIconVisible ?? (widget.child?.clickEnabled ?? false),
                  child: widget.child?.suffixIcon ??
                      CLGIcon(
                        path: CLGIcons.angleRight,
                        color: context.theme.gray.shade400,
                        size: 25,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: CLGClick(
              onClick: widget.child?.checkEnabled ?? false ? () => _checkItem(context, !state) : null,
              rippleColor: widget.child?.rippleColor,
              child: Center(
                child: _PrefixIcon(
                  key: Key('${widget.index}${checkVisible.toString()}${widget.child?.prefixIcon.hashCode ?? ''}'),
                  onInit: (value) {
                    _prefixWidth = value;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      widget.child?.prefixIcon ?? const SizedBox(),
                      if (checkVisible)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CLGCheckbox(
                            value: state,
                            shape: BoxShape.rectangle,
                            enable: widget.child?.checkEnabled ?? false,
                            onChanged: (value) => widget.child?.checkEnabled ?? false ? _checkItem(context, !state) : null,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkItem(BuildContext context, bool value) {
    if (widget.child?.checkEnabled ?? false) {
      if (value && !widget.controller.selectedMode) widget.controller.selectedMode = true;

      widget.controller.selectItem(widget.index, value);
      widget.itemCheck?.call(context, widget.index);
    }
  }

  void _clickItem(BuildContext context, bool value) {
    if (widget.controller.selectedMode && widget.controller.selecteds.isNotEmpty) {
      _checkItem(context, value);
    } else if (widget.child?.clickEnabled ?? false) {
      widget.itemClick?.call(context, widget.index);
    }
  }
}

class _PrefixIcon extends StatefulWidget {
  final Function(double width) onInit;
  final Widget child;

  const _PrefixIcon({
    super.key,
    required this.onInit,
    required this.child,
  });

  @override
  State<_PrefixIcon> createState() => __PrefixIconState();
}

class __PrefixIconState extends State<_PrefixIcon> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final box = context.findRenderObject() as RenderBox?;
      widget.onInit(box?.size.width ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
