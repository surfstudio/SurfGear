import 'dart:async';

import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

typedef NavElementBuilder = Widget Function(bool isSelected);

/// Bottom navigation bar widget.
class BottomNavBar extends StatefulWidget {
  final BottomNavTabType initType;
  final Map<BottomNavTabType, NavElementBuilder> elements;
  final StreamController<BottomNavTabType> selectedController;

  const BottomNavBar({
    Key key,
    @required this.selectedController,
    @required this.initType,
    @required this.elements,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  StreamSubscription _outerSubscription;
  BottomNavTabType _currentType;

  @override
  void initState() {
    super.initState();

    _currentType = widget.initType;

    _outerSubscription =
        widget.selectedController.stream.listen(_onSelectedChanged);
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
    if (event != _currentType) {
      setState(() {
        _currentType = event;
      });
    }
  }

  void _updateSelected(BottomNavTabType newSelected) {
    if (newSelected != _currentType) {
      setState(() {
        _currentType = newSelected;
        widget.selectedController.sink.add(newSelected);
      });
    }
  }

  @override
  void dispose() {
    _outerSubscription?.cancel();

    super.dispose();
  }
}
