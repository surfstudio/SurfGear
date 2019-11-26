import 'package:flutter/widgets.dart';
import 'package:mixed_list/src/item_builder.dart';

/// Mode visualisation of MixedList.
enum ListMode {
  grid,
  list,
}

/// Widget list for display different type of data.
class MixedList extends StatefulWidget {
  final EdgeInsets sliverPadding;

  final List items;

  final Map<Type, ItemBuilder> supportedItemControllers;

  final ScrollController scrollController;

  final ScrollPhysics scrollPhysics;

  final ListMode listMode;

  final SliverGridDelegate gridDelegate;

  final SliverChildBuilderDelegate itemsDelegate;

  MixedList({
    @required this.supportedItemControllers,
    @required this.items,
    @required this.listMode,
    this.scrollPhysics,
    this.scrollController,
    this.sliverPadding = const EdgeInsets.all(0),
    this.gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    this.itemsDelegate,
  }) {
    assert(this.supportedItemControllers != null);
    assert(this.items != null);
  }

  @override
  State<StatefulWidget> createState() => MixedListState();
}

class MixedListState<W extends MixedList> extends State<W> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: widget.scrollPhysics,
        controller: widget.scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: widget.sliverPadding,
            sliver: widget.listMode == ListMode.list
                ? SliverList(delegate: getItemDelegate())
                : SliverGrid(
                    delegate: getItemDelegate(),
                    gridDelegate: widget.gridDelegate,
                  ),
          )
        ]);
  }

  SliverChildBuilderDelegate getItemDelegate() {
    return widget.itemsDelegate ??
        SliverChildBuilderDelegate((ctx, position) {
          return buildItemWidget(
            context,
            position,
          );
        }, childCount: widget.items.length);
  }

  Widget buildItemWidget(
    BuildContext context,
    int position,
  ) {
    final item = widget.items[position];

    final controller = widget.supportedItemControllers[item.runtimeType];

    return controller.build(context, item);
  }
}
