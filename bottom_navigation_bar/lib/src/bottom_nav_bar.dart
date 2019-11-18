import 'dart:async';

import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tabnavigator/tabnavigator.dart';

typedef NavElementBuilder = Widget Function(bool isSelected);

/// Bottom navigation bar widget.
class BottomNavBar extends StatefulWidget {
  final StreamSink<TabType> selected;
  final BottomNavTabType initType;
  final Map<BottomNavTabType, NavElementBuilder> elements;
  final Stream<BottomNavTabType> outerSelector;

  const BottomNavBar({
    Key key,
    @required this.selected,
    @required this.initType,
    @required this.elements,
    this.outerSelector,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  BottomNavTabType _currentType;

  @override
  void initState() {
    super.initState();

    _currentType = widget.initType;

    if (widget.outerSelector != null) {
      widget.outerSelector.listen(_onSelectedChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildElements(),
    );
  }

  List<Widget> _buildElements() {
    List<Widget> widgets = [];

    widget.elements.forEach(
      (tabType, builder) => widgets.add(
        Expanded(child: _buildElement(builder, tabType)),
      ),
    );

    return widgets;
  }

  Widget _buildElement(NavElementBuilder builder, BottomNavTabType tabType) {
    return InkWell(
      child: builder(tabType == _currentType),
      onTap: () => _updateSelected(tabType),
    );
  }

  void _onSelectedChanged(BottomNavTabType event) {
    _updateSelected(event);
  }

  void _updateSelected(BottomNavTabType newSelected) {
    setState(() {
      _currentType = newSelected;
      widget.selected.add(newSelected);
    });
  }
}
