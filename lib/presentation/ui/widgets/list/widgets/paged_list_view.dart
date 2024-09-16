part of '../clg_list.dart';
//part of '../clg_paged_list.dart';

class _PagedListView<T> extends StatefulWidget {
  final CLGPagingController<T> controller;
  final Function(int page) loadNextPage;
  final CLGListItemBuilder itemBuilder;
  final CLGListItemCheck? itemCheck;
  final CLGListItemClick? itemClick;

  final Widget? loadingIndicator;
  final String? loadingMessage;
  final ScrollController scrollController;
  final double spacing;

  const _PagedListView({
    super.key,
    required this.controller,
    required this.loadNextPage,
    required this.itemBuilder,
    required this.itemCheck,
    required this.itemClick,
    required this.scrollController,
    this.loadingIndicator,
    this.loadingMessage,
    this.spacing = 0,
  });

  @override
  State<_PagedListView> createState() => __PagedListViewState<T>();
}

class __PagedListViewState<T> extends State<_PagedListView> {
  final duration = const Duration(milliseconds: 300);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_checkLoading);
    widget.controller.addListener(() {
      _isLoading = false;
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkLoading);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.controller.itemCount + 1,
      itemBuilder: (context, index) => generateChild(index),
    );
  }

  Widget generateChild(int index) {
    if (index < widget.controller.itemCount) {
      Widget child = widget.itemBuilder(context, index);

      if (child is CLGListTile) {
        child = _ListTile(
          index: index,
          controller: widget.controller,
          itemCheck: widget.itemCheck,
          itemClick: widget.itemClick,
          child: child,
        );
      }
      return Padding(
        padding: EdgeInsets.only(top: index != 0 ? widget.spacing : 0),
        child: child,
      );
    } else {
      return AnimatedSize(
        duration: duration,
        child: AnimatedSwitcher(
          duration: duration,
          child: _isLoading ? widget.loadingIndicator ?? _LoadingIndicator(widget.loadingMessage) : const SizedBox(),
        ),
      );
    }
  }

  void _checkLoading() {
    if (widget.scrollController.position.pixels >= widget.scrollController.position.maxScrollExtent && !_isLoading) {
      _isLoading = true;
      if (!mounted) return;
      setState(() {});
      widget.loadNextPage(widget.controller.page + 1);
    }
  }
}

class _LoadingIndicator extends StatelessWidget {
  final String? text;
  const _LoadingIndicator(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: context.theme.primary,
              strokeWidth: 3,
            ),
          ),
          CLGText(
            text ?? context.strings.loading,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.theme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
