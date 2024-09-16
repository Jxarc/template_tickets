part of '../clg_date.dart';

class _DateMode extends StatefulWidget {
  final _DateController controller;
  const _DateMode(this.controller, {super.key});

  @override
  State<_DateMode> createState() => _DateModeState();
}

class _DateModeState extends State<_DateMode> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.controller.inititalPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SelectorMonth(
          calendarController: widget.controller,
          controller: _controller,
        ),
        SizedBox(
          height: _height,
          child: PageView(
            controller: _controller,
            onPageChanged: (value) {
              widget.controller.monthDisplayed.value = value + 1 + widget.controller.startMonth;
            },
            children: List.generate(
              widget.controller.displayedMonths,
              (index) => _DisplayMonth(
                widget.controller,
                date: DateTime(widget.controller.yearDisplayed.value, index + widget.controller.startMonth + 1, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
