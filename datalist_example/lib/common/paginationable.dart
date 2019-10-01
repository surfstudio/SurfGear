import 'package:flutter/widgets.dart';

enum PaginationState { loading, error, none, complete }
enum ListMode { grid, list }

typedef PaginationBuilder = Widget Function(BuildContext, PaginationState);

class PaginationStateBuilder extends StatelessWidget {
  final PaginationBuilder paginationFooterBuilder;
  final VoidCallback onLoadMore;
  final Stream<PaginationState> currentPaginationState;
  final List<Widget> children;
  final List<Widget> headerSlivers;
  final ScrollController scrollController;
  final ListMode mode;
  final SliverGridDelegate gridDelegate;
  final EdgeInsets padding;
  final ScrollPhysics physics;

  const PaginationStateBuilder({
    Key key,
    this.paginationFooterBuilder,
    this.onLoadMore,
    this.currentPaginationState,
    this.children,
    this.scrollController,
    this.headerSlivers = const [],
    this.mode = ListMode.list,
    this.gridDelegate,
    this.padding = const EdgeInsets.all(0),
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PaginationState>(
      stream: currentPaginationState,
      initialData: PaginationState.none,
      builder: (ctx, snapshot) => PaginationList(
            currentPaginationState: snapshot.data,
            onLoadMore: onLoadMore,
            paginationFooterBuilder: paginationFooterBuilder,
            children: children,
            scrollController: scrollController,
            headerSlivers: headerSlivers,
            mode: mode,
            gridDelegate: gridDelegate,
            padding: padding,
            physics: physics,
          ),
    );
  }
}

class PaginationList extends StatefulWidget {
  final PaginationBuilder paginationFooterBuilder;
  final VoidCallback onLoadMore;
  final PaginationState currentPaginationState;
  final List<Widget> children;
  final List<Widget> headerSlivers;
  final ScrollController scrollController;
  final ListMode mode;
  final SliverGridDelegate gridDelegate;
  final EdgeInsets padding;
  final ScrollPhysics physics;

  const PaginationList({
    Key key,
    this.paginationFooterBuilder,
    this.onLoadMore,
    this.currentPaginationState,
    this.children,
    this.scrollController,
    this.headerSlivers = const [],
    this.mode = ListMode.list,
    this.gridDelegate,
    this.padding = const EdgeInsets.all(0),
    this.physics,
  })  : assert(mode == ListMode.list || gridDelegate != null),
        super(key: key);

  @override
  _PaginationListState createState() => _PaginationListState();
}

class _PaginationListState extends State<PaginationList> {
  bool _isLoading = false;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = widget.currentPaginationState == PaginationState.loading;

    Widget paginationFooter = widget.paginationFooterBuilder(
      context,
      widget.currentPaginationState,
    );

    List<Widget> children = widget.children;

    final delegate = SliverChildBuilderDelegate(
      (ctx, i) {
        if (i > children.length / 2 &&
            !_isLoading &&
            widget.currentPaginationState != PaginationState.complete) {
          widget.onLoadMore();
          _isLoading = !_isLoading;
        }
        return children[i];
      },
      childCount: children.length,
    );

    return CustomScrollView(
      physics: widget.physics,
      controller: _scrollController,
      slivers: <Widget>[
        ...widget.headerSlivers,
        SliverPadding(
          padding: widget.padding,
          sliver: widget.mode == ListMode.list
              ? SliverList(delegate: delegate)
              : SliverGrid(
                  delegate: delegate,
                  gridDelegate: widget.gridDelegate,
                ),
        ),
        if (_isLoading)
          SliverToBoxAdapter(
            child: paginationFooter,
          )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
