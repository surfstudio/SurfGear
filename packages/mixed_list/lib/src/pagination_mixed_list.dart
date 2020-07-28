import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mixed_list/src/item_builder.dart';
import 'package:mixed_list/src/mixed_list.dart';
import 'package:mixed_list/src/pagination_state.dart';

/// Signature for the building widget by pagination state.
typedef PaginationBuilder = Widget Function(BuildContext, PaginationState);

/// Signature for the init next loading.
typedef PaginationPredicate = bool Function(int position);

/// Widget list for display different type of data with pagination.
class PaginationMixedList extends MixedList {
  const PaginationMixedList({
    @required List items,
    @required Map<Type, ItemBuilder> supportedItemControllers,
    @required ListMode listMode,
    @required this.onLoadMore,
    @required this.paginationState,
    Key key,
    this.paginationFooterBuilder,
    this.paginationPredicate,
    this.headerSlivers = const [],
    ScrollPhysics scrollPhysics,
    ScrollController scrollController,
    SliverGridDelegate gridDelegate,
    SliverChildBuilderDelegate itemsDelegate,
  }) : super(
          key: key,
          supportedItemControllers: supportedItemControllers,
          items: items,
          listMode: listMode,
          scrollPhysics: scrollPhysics,
          scrollController: scrollController,
          gridDelegate: gridDelegate,
          itemsDelegate: itemsDelegate,
        );

  /// Function that will be called when need load more data.
  final VoidCallback onLoadMore;

  /// Current pagination state.
  final Stream<PaginationState> paginationState;

  /// Predicate that determine, is need load more data now.
  final PaginationPredicate paginationPredicate;

  /// Builder for footer of list. That wil be display under all items.
  final PaginationBuilder paginationFooterBuilder;

  /// Slivers that will be display before the first items in list.
  final List<Widget> headerSlivers;

  @override
  State<StatefulWidget> createState() => _PaginationState();
}

class _PaginationState extends MixedListState<PaginationMixedList> {
  PaginationState _currentState = PaginationState.none;
  StreamSubscription<PaginationState> _stateSubscription;
  PaginationPredicate _defaultPaginationPredicate;

  var _isLoading = false;

  @override
  void initState() {
    _defaultPaginationPredicate = (position) {
      final isComplete = _currentState == PaginationState.complete;
      final isError = _currentState == PaginationState.error;

      final itemsLength = widget.items.length;

      return position > itemsLength / 2 &&
          !_isLoading &&
          !isComplete &&
          !isError;
    };

    _stateSubscription = widget.paginationState.listen((state) {
      setState(() {
        _currentState = state;

        _isLoading = _currentState == PaginationState.loading;
      });
    });

    if (_currentState != PaginationState.complete && widget.items.isEmpty) {
      widget.onLoadMore();
      _isLoading = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();

    super.dispose();
  }

  @override
  SliverChildBuilderDelegate getItemDelegate() {
    final itemsLength = widget.items.length;

    return SliverChildBuilderDelegate(
      (ctx, position) {
        if (_isNeedLoading(position)) {
          _isLoading = true;
          widget.onLoadMore();
        }
        return buildItemWidget(
          context,
          position,
        );
      },
      childCount: itemsLength,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: widget.scrollPhysics,
        controller: widget.scrollController,
        slivers: <Widget>[
          ...widget.headerSlivers,
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
            child: _paginationFooter(context),
          )
        ]);
  }

  Widget _paginationFooter(BuildContext context) {
    return widget.paginationFooterBuilder(context, _currentState);
  }

  bool _isNeedLoading(int position) {
    if (widget.paginationPredicate != null) {
      return widget.paginationPredicate(position);
    } else {
      return _defaultPaginationPredicate(position);
    }
  }
}
