import 'package:flutter/widgets.dart';
import 'package:mixed_list/src/item_builder.dart';

enum ListMode { grid, list }

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
  State<StatefulWidget> createState() {
    return MixedListState(
      this.supportedItemControllers,
      this.items,
    );
  }
}

class MixedListState extends State<MixedList> {
  final Map<Type, ItemBuilder> supportedItemControllers;
  final List items;

  MixedListState(
    this.supportedItemControllers,
    this.items,
  );

  SliverChildBuilderDelegate getItemDelegate() {
    return widget.itemsDelegate ??
        SliverChildBuilderDelegate((ctx, position) {
          return buildItemWidget(
            context,
            position,
          );
        }, childCount: items.length);
  }

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

  Widget buildItemWidget(
    BuildContext context,
    int position,
  ) {
    final item = items[position];

    final controller = supportedItemControllers[item.runtimeType];

    return controller.build(context, item);
  }
}
