import 'package:flutter/widgets.dart';
import 'package:mixed_list/src/item_builder.dart';

/// Mode visualisation of MixedList.
enum ListMode {
  grid,
  list,
}

/// Widget list for display different type of data.
class MixedList extends StatefulWidget {
  /// The amount of space by which to inset the child sliver.
  final EdgeInsets sliverPadding;

  /// Items for display.
  final List items;

  /// Map of relationship between type of item and build function for them.
  final Map<Type, ItemBuilder> supportedItemControllers;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  final ScrollController scrollController;

  /// How the scroll view should respond to user input.
  final ScrollPhysics scrollPhysics;

  /// Mode of display children list.
  final ListMode listMode;

  /// The delegate that controls the size and position of the children,
  /// if mode is Grid.
  final SliverGridDelegate gridDelegate;

  /// The delegate that provides the children for this widget.
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
  })  : assert(supportedItemControllers != null),
        assert(items != null);

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

  @protected
  SliverChildBuilderDelegate getItemDelegate() {
    return widget.itemsDelegate ??
        SliverChildBuilderDelegate((ctx, position) {
          return buildItemWidget(
            context,
            position,
          );
        }, childCount: widget.items.length);
  }

  @protected
  Widget buildItemWidget(
    BuildContext context,
    int position,
  ) {
    final item = widget.items[position];

    final controller = widget.supportedItemControllers[item.runtimeType];

    return controller.build(context, item);
  }
}
