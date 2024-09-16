part of '../clg_list.dart';

class _ListView<T> extends StatefulWidget {
  final CLGPagingController<T> controller;
  final CLGListItemBuilder itemBuilder;
  final ScrollController scrollController;
  final CLGListItemCheck? itemCheck;
  final CLGListItemClick? itemClick;
  final double spacing;

  const _ListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.scrollController,
    required this.itemCheck,
    required this.itemClick,
    this.spacing = 0,
  });

  @override
  State<_ListView> createState() => __ListViewState<T>();
}

class __ListViewState<T> extends State<_ListView> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.controller.itemCount,
      itemBuilder: (context, index) {
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
      },
    );
  }
}
