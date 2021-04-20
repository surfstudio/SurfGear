import 'package:flutter/widgets.dart';

class FlexibleBottomSheetHeaderDelegate extends SliverPersistentHeaderDelegate {
  FlexibleBottomSheetHeaderDelegate({
    required this.maxHeight,
    required this.child,
    this.minHeight = 0,
  });

  final Widget child;

  final double minHeight;

  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }
}
