part of '../clg_date.dart';

class _SelectorMonth extends StatefulWidget {
  final _DateController calendarController;
  final PageController controller;
  const _SelectorMonth({
    required this.calendarController,
    required this.controller,
  });

  @override
  State<_SelectorMonth> createState() => _SelectorMonthState();
}

class _SelectorMonthState extends State<_SelectorMonth> {
  late PageController _controller;

  int _lengthMonths = 12;
  int _currentPosition = 0;
  bool _onChangeEnable = false;

  @override
  void initState() {
    _currentPosition = widget.calendarController.inititalPage;
    _lengthMonths = widget.calendarController.displayedMonths;

    _controller = PageController(initialPage: _currentPosition);
    super.initState();

    _onChangeEnable = true;
    widget.controller.addListener(_checkScroll);
  }

  _checkScroll() async {
    if (widget.controller.page == _controller.page) return;
    widget.controller.removeListener(_checkScroll);
    _onChangeEnable = false;
    final value = widget.controller.page ?? 0;
    final diff = value.abs() - _currentPosition.abs();

    if (value == value.toInt()) _currentPosition = value.toInt();

    if (diff.abs() > 0.5) {
      if (diff > 0) {
        _currentPosition++;
        if (_currentPosition >= _lengthMonths) _currentPosition = _lengthMonths - 1;
        await _controller.animateToPage(
          _currentPosition,
          duration: const Duration(milliseconds: 400),
          curve: Curves.decelerate,
        );
        if (mounted) setState(() {});
      }

      if (diff < 0) {
        _currentPosition--;
        if (_currentPosition < 0) _currentPosition = 0;
        await _controller.animateToPage(
          _currentPosition,
          duration: const Duration(milliseconds: 400),
          curve: Curves.decelerate,
        );
        if (mounted) setState(() {});
      }
    }
    _onChangeEnable = true;
    widget.controller.addListener(_checkScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.calendarController.style?.activeColor ?? context.theme.calendarActiveColor;
    final disabledColor = widget.calendarController.style?.disabledColor ?? context.theme.calendarDisabledColor;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            left: 40,
            right: 40,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => widget.calendarController.toggleYearMode(),
                child: Center(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) {
                      if (_onChangeEnable) {
                        widget.controller.animateToPage(
                          value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        );
                      }
                    },
                    children: List.generate(
                      widget.calendarController.displayedMonths,
                      (index) => Center(
                        child: ValueListenableBuilder<int>(
                            valueListenable: widget.calendarController.yearDisplayed,
                            builder: (context, value, child) {
                              return CLGText(
                                _monthLabel(value, index + widget.calendarController.startMonth + 1, widget.calendarController.locale),
                                textAlign: TextAlign.center,
                                style: widget.calendarController.style?.monthTextStyle?.copyWith(
                                      color: widget.calendarController.style?.monthTextColor ?? context.theme.calendarTextColor,
                                    ) ??
                                    context.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: widget.calendarController.style?.monthTextColor ?? context.theme.calendarTextColor,
                                    ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _currentPosition != 0
                ? () {
                    widget.controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  }
                : null,
            icon: CLGIcon(
              path: CLGIcons.angleLeft,
              color: _currentPosition != 0 ? activeColor : disabledColor,
              size: 24,
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: _currentPosition != widget.calendarController.displayedMonths - 1
                  ? () {
                      widget.controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                      );
                    }
                  : null,
              icon: CLGIcon(
                path: CLGIcons.angleRight,
                color: _currentPosition != widget.calendarController.displayedMonths - 1 ? activeColor : disabledColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
