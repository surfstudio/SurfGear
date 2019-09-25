import 'package:flutter/widgets.dart';
import 'package:mixed_list/src/item_builder.dart';
import 'package:mixed_list/src/mixed_list.dart';

typedef PaginationBuilder = Widget Function(BuildContext, PaginationState);

enum PaginationState { loading, error, none, complete }

class PaginationMixedList extends MixedList {
  final VoidCallback onLoadMore;

  final PaginationState currentPaginationState;

  final PaginationBuilder paginationFooterBuilder;

  final List<Widget> headerSlivers;

  PaginationMixedList({
    this.paginationFooterBuilder,
    this.headerSlivers = const [],
    ScrollPhysics scrollPhysics,
    ScrollController scrollController,
    SliverPadding sliverPadding,
    SliverGridDelegate gridDelegate,
    SliverChildBuilderDelegate itemsDelegate,
    @required List items,
    @required Map<Type, ItemBuilder> supportedItemControllers,
    @required ListMode listMode,
    @required this.onLoadMore,
    @required this.currentPaginationState,
  }) : super(
    supportedItemControllers: supportedItemControllers,
    items: items,
    listMode: listMode,
    scrollPhysics: scrollPhysics,
    scrollController: scrollController,
    gridDelegate: gridDelegate,
    itemsDelegate: itemsDelegate,
  );

  @override
  State<StatefulWidget> createState() {
    return _PaginationState(
      supportedItemControllers,
      items,
      currentPaginationState,
      onLoadMore,
      paginationFooterBuilder,
      headerSlivers,
    );
  }
}

class _PaginationState extends MixedListState {
  final PaginationState currentPaginationState;

  final VoidCallback onLoadMore;

  final PaginationBuilder paginationFooterBuilder;

  final List<Widget> headerSlivers;

  bool _isLoading = false;

  _PaginationState(Map<Type, ItemBuilder> supportedItemControllers,
      List items,
      this.currentPaginationState,
      this.onLoadMore,
      this.paginationFooterBuilder,
      this.headerSlivers,) : super(
    supportedItemControllers,
    items,
  );

  @override
  SliverChildBuilderDelegate getItemDelegate() {
    _isLoading = currentPaginationState == PaginationState.loading;

    return SliverChildBuilderDelegate(
          (ctx, position) {
        if (position > items.length / 2 &&
            !_isLoading &&
            currentPaginationState != PaginationState.complete) {
          onLoadMore();
          _isLoading = !_isLoading;
        }
        return buildItemWidget(
          context,
          position,
        );
      },
      childCount: items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: widget.scrollPhysics,
        controller: widget.scrollController,
        slivers: <Widget>[
          ...headerSlivers,
          SliverPadding(
            padding: widget.sliverPadding,
            sliver: widget.listMode == ListMode.list
                ? SliverList(delegate: getItemDelegate())
                : SliverGrid(
              delegate: getItemDelegate(),
              gridDelegate: widget.gridDelegate,
            ),
          ),
          SliverToBoxAdapter(
            child: paginationFooter(context),
          )
        ]);
  }

  Widget paginationFooter(BuildContext context) {
    return paginationFooterBuilder(context, currentPaginationState);
  }
}
