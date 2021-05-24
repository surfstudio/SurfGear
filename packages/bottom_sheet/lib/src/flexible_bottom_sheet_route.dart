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

import 'package:bottom_sheet/src/flexible_bottom_sheet.dart';
import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

// ignore_for_file: avoid-returning-widgets

const Duration _bottomSheetDuration = Duration(milliseconds: 500);

/// Shows a flexible bottom sheet.
///
/// [builder] - content's builder
/// [minHeight] - min height in percent for bottom sheet. e.g. 0.1
/// [initHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [maxHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [isModal] - if true, overlay background with dark color
/// [anchors] - percent height that bottom sheet can be
Future<T?> showFlexibleBottomSheet<T>({
  required BuildContext context,
  required FlexibleDraggableScrollableWidgetBuilder builder,
  double? minHeight,
  double? initHeight,
  double? maxHeight,
  bool isCollapsible = true,
  bool isExpand = true,
  bool useRootNavigator = false,
  bool isModal = true,
  List<double>? anchors,
}) {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _FlexibleBottomSheetRoute<T>(
      theme: Theme.of(context),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      minHeight: minHeight ?? 0,
      initHeight: initHeight ?? 0.5,
      maxHeight: maxHeight ?? 1,
      isCollapsible: isCollapsible,
      isExpand: isExpand,
      builder: builder,
      isModal: isModal,
      anchors: anchors,
    ),
  );
}

/// Shows a flexible bottom sheet with the ability to scroll content
/// even without a list
///
/// [builder] - content's builder
/// [minHeight] - min height in percent for bottom sheet. e.g. 0.1
/// [initHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [maxHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [isModal] - if true, overlay background with dark color
/// [anchors] - percent height that bottom sheet can be
/// isPinnedHeader - can the header scroll
/// [decoration] - BottomSheet decoration
/// [minHeaderHeight] - minimum head size
/// [maxHeaderHeight] - maximum head size
/// [headerHeight] - head size.
/// decoratedBox - decoration for header and content
/// Sets both [minHeaderHeight] and [maxHeaderHeight]
Future<T?> showStickyFlexibleBottomSheet<T>({
  required BuildContext context,
  required FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder,
  required FlexibleDraggableScrollableWidgetBodyBuilder builder,
  double? minHeight,
  double? initHeight,
  double? maxHeight,
  bool isCollapsible = true,
  bool isExpand = true,
  bool useRootNavigator = false,
  bool isModal = true,
  List<double>? anchors,
  double? minHeaderHeight,
  double? maxHeaderHeight,
  double? headerHeight,
  Decoration? decoration,
}) {
  assert(maxHeaderHeight != null || headerHeight != null);
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _FlexibleBottomSheetRoute<T>(
      theme: Theme.of(context),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      minHeight: minHeight ?? 0,
      initHeight: initHeight ?? 0.5,
      maxHeight: maxHeight ?? 1,
      isCollapsible: isCollapsible,
      isExpand: isExpand,
      bodyBuilder: builder,
      headerBuilder: headerBuilder,
      isModal: isModal,
      anchors: anchors,
      minHeaderHeight: minHeaderHeight ?? headerHeight ?? maxHeaderHeight! / 2,
      maxHeaderHeight: maxHeaderHeight ?? headerHeight!,
      decoration: decoration,
    ),
  );
}

/// A modal route with flexible bottom sheet.
class _FlexibleBottomSheetRoute<T> extends PopupRoute<T> {
  _FlexibleBottomSheetRoute({
    required this.minHeight,
    required this.initHeight,
    required this.maxHeight,
    required this.isCollapsible,
    required this.isExpand,
    required this.isModal,
    this.builder,
    this.headerBuilder,
    this.bodyBuilder,
    this.theme,
    this.barrierLabel,
    this.anchors,
    this.minHeaderHeight,
    this.maxHeaderHeight,
    this.decoration,
    RouteSettings? settings,
  }) : super(settings: settings);

  final FlexibleDraggableScrollableWidgetBuilder? builder;
  final FlexibleDraggableScrollableHeaderWidgetBuilder? headerBuilder;
  final FlexibleDraggableScrollableWidgetBodyBuilder? bodyBuilder;
  final double minHeight;
  final double initHeight;
  final double maxHeight;
  final bool isCollapsible;
  final bool isExpand;
  final bool isModal;
  final List<double>? anchors;
  final double? minHeaderHeight;
  final double? maxHeaderHeight;
  final Decoration? decoration;

  final ThemeData? theme;

  @override
  Duration get transitionDuration => _bottomSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color? get barrierColor => isModal ? Colors.black54 : const Color(0x00FFFFFF);

  late AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    _animationController = AnimationController(
      duration: _bottomSheetDuration,
      debugLabel: 'FlexibleBottomSheet',
      vsync: (navigator?.overlay)!,
    );

    return _animationController;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: isCollapsible
          ? FlexibleBottomSheet.collapsible(
              initHeight: initHeight,
              maxHeight: maxHeight,
              builder: builder,
              headerBuilder: headerBuilder,
              bodyBuilder: bodyBuilder,
              isExpand: isExpand,
              animationController: _animationController,
              anchors: anchors,
              minHeaderHeight: minHeaderHeight,
              maxHeaderHeight: maxHeaderHeight,
              decoration: decoration,
            )
          : FlexibleBottomSheet(
              minHeight: minHeight,
              initHeight: initHeight,
              maxHeight: maxHeight,
              builder: builder,
              headerBuilder: headerBuilder,
              bodyBuilder: bodyBuilder,
              isExpand: isExpand,
              animationController: _animationController,
              anchors: anchors,
              minHeaderHeight: minHeaderHeight,
              maxHeaderHeight: maxHeaderHeight,
              decoration: decoration,
            ),
    );

    if (theme != null) {
      bottomSheet = Theme(data: theme!, child: bottomSheet);
    }

    return bottomSheet;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      ),
    );
  }
}
