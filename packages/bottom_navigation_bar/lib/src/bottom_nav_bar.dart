// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

typedef NavElementBuilder = Widget Function(bool isSelected);

/// Bottom navigation bar widget.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    required this.selectedController,
    required this.initType,
    required this.elements,
    Key? key,
  }) : super(key: key);

  final BottomNavTabType initType;
  final Map<BottomNavTabType, NavElementBuilder> elements;
  final StreamController<BottomNavTabType> selectedController;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late BottomNavTabType _currentType;
  late StreamSubscription _outerSubscription;

  @override
  void initState() {
    super.initState();

    _currentType = widget.initType;
    _outerSubscription =
        widget.selectedController.stream.listen(_onSelectedChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (final entry in widget.elements.entries)
        Expanded(
          child: InkWell(
            onTap: () => _updateSelected(entry.key),
            child: entry.value(entry.key == _currentType),
          ),
        ),
    ]);
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
    _outerSubscription.cancel();

    super.dispose();
  }
}
