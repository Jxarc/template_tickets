import 'package:flutter/material.dart';
import 'package:template/presentation/ui/ui.dart';

class CLGOptionFloatingActionButton {
  final VoidCallback onClick;
  final String? text;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? icon;

  CLGOptionFloatingActionButton({
    required this.onClick,
    this.text,
    this.textColor,
    this.textStyle,
    this.icon,
  });
}

class CLGFloatingActionButton extends StatefulWidget {
  final double size;
  final Color? color;
  final List<Color>? colors;

  final List<CLGOptionFloatingActionButton>? children;
  final Widget child;

  final double elevation;
  final VoidCallback onClick;
  final BorderRadius? borderRadius;

  final Color? popupColor;
  final EdgeInsets? popupPadding;

  final String text;
  final Color? textColor;
  final TextStyle? textStyle;

  final bool isExpanded;
  final bool setIconsRight;
  final EdgeInsets? padding;

  const CLGFloatingActionButton({
    Key? key,
    required this.child,
    required this.onClick,
    this.popupColor,
    this.popupPadding,
    this.size = 55,
    this.color,
    this.colors,
    this.elevation = 1,
    this.children,
    this.text = '',
    this.textColor,
    this.textStyle,
    this.isExpanded = false,
    this.setIconsRight = false,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  State<CLGFloatingActionButton> createState() => _CLGFloatingActionButtonState();
}

class _CLGFloatingActionButtonState extends State<CLGFloatingActionButton> {
  bool _popupIsOpen = false;
  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular((widget.size * 100));

    var colorsGradient = widget.colors;

    final textWidget = _AnimatedText(
      text: widget.text,
      textColor: widget.textColor,
      textStyle: widget.textStyle,
    );

    final buttonWidget = AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: () {
          if (widget.children != null) _showDialog(context);
          widget.onClick();
        },
        style: ElevatedButton.styleFrom(
          padding: widget.padding ?? const EdgeInsets.all(8),
          minimumSize: Size(widget.size, widget.size),
          shape: RoundedRectangleBorder(
            borderRadius: radius,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: context.theme.primary,
          elevation: 0,
          animationDuration: const Duration(milliseconds: 500),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            if (widget.isExpanded && !_popupIsOpen)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget,
                ),
              ),
          ],
        ),
      ),
    );

    if (colorsGradient != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
              blurRadius: widget.elevation / 2,
              offset: const Offset(0, 1),
            ) //blur radius of shadow
          ],
          borderRadius: radius,
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: colorsGradient),
        ),
        child: buttonWidget,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: colorsGradient == null ? widget.color ?? context.theme.primary : null,
        boxShadow: widget.elevation > 0
            ? [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                  blurRadius: widget.elevation / 2,
                  offset: const Offset(0, 1),
                ) //blur radius of shadow
              ]
            : null,
        borderRadius: radius,
        gradient: colorsGradient != null
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colorsGradient,
              )
            : null,
      ),
      child: buttonWidget,
    );
    // return buttonWidget;
  }

  void _showDialog(BuildContext context) async {
    _popupIsOpen = true;
    setState(() {});

    await Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => _OptionsDialog(
          children: widget.children,
          popupColor: widget.popupColor,
          popupPadding: widget.popupPadding,
          icon: widget.child,
          text: widget.text,
          textColor: widget.textColor,
          textStyle: widget.textStyle,
          padding: widget.padding,
          isExpanded: widget.isExpanded,
          borderRadius: widget.borderRadius,
          setIconsRight: widget.setIconsRight,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.decelerate),
          child: child,
        ),
      ),
    );

    _popupIsOpen = false;
    if (!mounted) return;
    setState(() {});
  }
}

class _AnimatedText extends StatefulWidget {
  final String text;
  final Color? textColor;
  final TextStyle? textStyle;
  const _AnimatedText({
    required this.text,
    required this.textColor,
    required this.textStyle,
  });

  @override
  State<_AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<_AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: child,
        );
      },
      child: CLGText(
        widget.text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: widget.textStyle?.copyWith(
              color: widget.textColor ?? context.theme.floatingActionButtonOnPrimary,
            ) ??
            context.textTheme.bodyMedium?.copyWith(
              color: widget.textColor ?? context.theme.floatingActionButtonOnPrimary,
            ),
      ),
    );
  }
}

class _OptionsDialog extends StatelessWidget {
  final List<CLGOptionFloatingActionButton>? children;
  final double size;
  final Color? popupColor;
  final EdgeInsets? popupPadding;
  final Widget icon;
  final String text;
  final Color? textColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;

  final bool isExpanded;
  final bool setIconsRight;
  final EdgeInsets? padding;
  const _OptionsDialog({
    Key? key,
    required this.icon,
    this.size = 50,
    this.children,
    this.popupColor,
    this.popupPadding,
    this.text = '',
    this.textColor,
    this.textStyle,
    this.isExpanded = false,
    this.setIconsRight = false,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.black.withOpacity(0.5),
      floatingActionButton: Padding(
        padding: popupPadding ?? EdgeInsets.zero,
        child: _AnimatedChildren(
          children: children,
          popupColor: popupColor,
          icon: icon,
          text: text,
          textColor: textColor,
          textStyle: textStyle,
          isExpanded: isExpanded,
          borderRadius: borderRadius,
          padding: padding,
          size: size,
          setIconsRight: setIconsRight,
        ),
      ),
      body: InkWell(
        enableFeedback: false,
        highlightColor: context.theme.black.withOpacity(0.01),
        splashColor: context.theme.black.withOpacity(0.01),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}

class _AnimatedChildren extends StatefulWidget {
  final List<CLGOptionFloatingActionButton>? children;
  final double size;
  final Color? popupColor;
  final Widget icon;
  final String text;
  final Color? textColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;

  final bool isExpanded;
  final bool setIconsRight;
  final EdgeInsets? padding;
  const _AnimatedChildren({
    Key? key,
    required this.icon,
    required this.size,
    this.children,
    this.popupColor,
    this.text = '',
    this.textColor,
    this.textStyle,
    this.isExpanded = false,
    this.setIconsRight = false,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  State<_AnimatedChildren> createState() => __AnimatedChildrenState();
}

class __AnimatedChildrenState extends State<_AnimatedChildren> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.only(bottom: widget.size + 10, left: 30),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.popupColor ?? context.theme.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: -5,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.children?.length ?? 0,
              (index) => Padding(
                padding: EdgeInsets.only(top: index != 0 ? 2 : 0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide.none,
                    foregroundColor: context.theme.primary.shade200,
                  ),
                  onPressed: () {
                    _close();
                    widget.children![index].onClick();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!widget.setIconsRight)
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 10),
                          child: InkWell(
                            child: widget.children![index].icon,
                            onTap: () {},
                          ),
                        ),
                      const SizedBox(width: 10),
                      if (widget.children![index].text != null)
                        Expanded(
                          child: CLGText(
                            widget.children![index].text!,
                            overflow: TextOverflow.ellipsis,
                            style: widget.children![index].textStyle?.copyWith(
                                  color: widget.children![index].textColor ?? context.theme.textColor,
                                ) ??
                                context.textTheme.bodyLarge?.copyWith(
                                  color: widget.children![index].textColor ?? context.theme.textColor,
                                ),
                            maxLines: 2,
                          ),
                        ),
                      if (widget.setIconsRight)
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 10),
                          child: InkWell(
                            child: widget.children![index].icon,
                            onTap: () {},
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _close() {
    Navigator.pop(context);
  }
}
