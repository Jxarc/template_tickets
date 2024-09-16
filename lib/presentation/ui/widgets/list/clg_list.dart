import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/clg_sliver_header.dart';

part 'widgets/list_view.dart';
part 'widgets/paged_list_view.dart';
part 'widgets/clg_list_tile.dart';

typedef CLGListItemBuilder = Widget Function(BuildContext context, int index);
typedef CLGListItemClick = Function(BuildContext context, int index);
typedef CLGListItemCheck = Function(BuildContext context, int index);

class CLGList<Provider> extends StatelessWidget {
  final List<CLGPinned> pinneds;
  final List<CLGListAction> actions;
  final ScrollController? controller;
  final Widget? loadingState;
  final Widget? emptyState;
  final Widget? headerList;
  final double headerSize;
  final Widget? footerList;
  final CLGListItemBuilder itemBuilder;
  final CLGListItemCheck? itemCheck;
  final CLGListItemClick? itemClick;
  final double? stateHeight;
  final double? stateWidth;
  final EdgeInsets? padding;
  final bool paged;
  final double spacing;

  const CLGList({
    super.key,
    required this.itemBuilder,
    this.itemClick,
    this.headerSize = 45,
    this.itemCheck,
    this.loadingState,
    this.emptyState,
    this.headerList,
    this.footerList,
    this.pinneds = const [],
    this.actions = const [],
    this.stateHeight,
    this.stateWidth,
    this.padding,
    this.controller,
    this.paged = false,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<Provider>() as CLGProvider;
    if (controller != null) provider.pagingController.scrollController = controller!;

    return CLGRefreshIndicator(
      onRefresh: () {
        provider.isRefresh = true;
        if (paged) {
          return provider.loadPagedData();
        } else {
          return provider.loadData();
        }
      },
      color: context.theme.white,
      backgroundColor: context.theme.primary,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: provider.pagingController.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                ...pinneds.map(
                  (e) => SliverPersistentHeader(
                    pinned: e.pinned,
                    delegate: CLGSliverHeaderDelegate(
                      maxHeight: e.maxHeight,
                      minHeight: e.minHeight,
                      child: Container(
                        padding: e.padding,
                        clipBehavior: Clip.none,
                        color: e.color,
                        child: e.child ?? const SizedBox(),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: provider.pagingController,
                  builder: (context, value, child) => SliverPersistentHeader(
                    pinned: true,
                    delegate: CLGSliverHeaderDelegate(
                      maxHeight: provider.pagingController.selecteds.isNotEmpty || headerList != null ? headerSize : 0,
                      minHeight: provider.pagingController.selecteds.isNotEmpty || headerList != null ? headerSize : 0,
                      child: _ListHeader(
                        controller: provider.pagingController,
                        child: headerList ?? const SizedBox(),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: padding ?? EdgeInsets.zero,
                        child: CLGStates<Provider>(
                          loadingState: loadingState,
                          emptyState: emptyState,
                          stateHeight: stateHeight,
                          stateWidth: stateWidth,
                          child: paged
                              ? _PagedListView(
                                  spacing: spacing,
                                  scrollController: provider.pagingController.scrollController,
                                  controller: provider.pagingController,
                                  itemBuilder: itemBuilder,
                                  itemCheck: itemCheck,
                                  itemClick: itemClick,
                                  loadNextPage: (page) => provider.loadPagedData(page),
                                )
                              : _ListView(
                                  spacing: spacing,
                                  scrollController: provider.pagingController.scrollController,
                                  controller: provider.pagingController,
                                  itemBuilder: itemBuilder,
                                  itemCheck: itemCheck,
                                  itemClick: itemClick,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: provider.pagingController,
            builder: (context, value, child) => Visibility(
              visible: footerList != null && provider.pagingController.selecteds.isNotEmpty,
              child: footerList ?? const SizedBox(),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: provider.pagingController,
            builder: (context, value, child) => Visibility(
              visible: actions.isNotEmpty && provider.pagingController.selecteds.isNotEmpty,
              child: CLGCard(
                color: context.theme.background,
                borderColor: context.theme.gray.shade100,
                borderRadius: 0,
                elevation: 0.5,
                borderWidth: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: actions.map((e) => Expanded(child: e)).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListHeader extends StatelessWidget {
  final CLGPagingController controller;
  final Widget? child;

  const _ListHeader({
    super.key,
    required this.controller,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.selecteds.isEmpty) return child ?? const SizedBox();
    final isAllSelected = controller.selecteds.length == controller.itemCount;

    return CLGCard(
      elevation: 1,
      borderRadius: 0,
      child: CLGClick(
        backgroundColor: context.theme.secondary.shade100,
        rippleColor: context.theme.secondary.shade200.withOpacity(0.5),
        padding: const EdgeInsets.all(8),
        onClick: () => controller.selectAll(!isAllSelected),
        child: Row(
          children: [
            CLGIcon(
              path: CLGIcons.layerGroup,
              color: context.theme.secondary.shade700,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CLGText(
                !isAllSelected ? context.strings.select_all : context.strings.unselect_all,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.theme.secondary.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CLGCard(
              height: double.infinity,
              color: context.theme.white,
              elevation: 0.5,
              borderRadius: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: CLGText(
                    '${controller.selecteds.length}/${controller.itemCount}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.secondary.shade600,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CLGListAction extends StatelessWidget {
  final String icon;
  final Color? iconColor;
  final String text;
  final VoidCallback? onClick;
  final bool enabled;
  final String tooltipMessage;
  const CLGListAction({
    super.key,
    this.icon = '',
    this.text = '',
    this.enabled = true,
    this.tooltipMessage = '',
    this.iconColor,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return CLGTooltip(
      showOnTap: !enabled && tooltipMessage.isNotEmpty,
      waitDuration: const Duration(seconds: 3),
      tooltip: CLGText(
        tooltipMessage,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.theme.white,
        ),
      ),
      child: CLGClick(
        onClick: !enabled && tooltipMessage.isNotEmpty ? null : onClick,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            CLGIcon(
              path: icon,
              size: 30,
              color: enabled ? iconColor ?? context.theme.primary : context.theme.gray.shade200,
            ),
            CLGText(
              text,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: enabled ? context.theme.gray.shade400 : context.theme.gray.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
