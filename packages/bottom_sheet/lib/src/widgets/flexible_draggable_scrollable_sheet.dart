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

// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// The signature of a method that provides a [BuildContext] and
/// [ScrollController] for building a widget that may overflow the draggable
/// [Axis] of the containing FlexibleDraggableScrollSheet.
///
/// Users should apply the [scrollController] to a [ScrollView] subclass, such
/// as a [SingleChildScrollView], [ListView] or [GridView], to have the whole
/// sheet be draggable.
///
/// [bottomSheetOffset] - percent of offset
typedef FlexibleDraggableScrollableWidgetBuilder = Widget Function(
  BuildContext context,
  FlexibleDraggableScrollableSheetScrollController scrollController,
  double bottomSheetOffset,
);

/// The signature of the method that provides [BuildContext]
/// and [bottomSheetOffset] for determining the position of the BottomSheet
/// relative to the upper border of the screen
///
typedef FlexibleDraggableScrollableHeaderWidgetBuilder = Widget Function(
  BuildContext context,
  double bottomSheetOffset,
);

/// The signature of a method that provides a [BuildContext]
/// and [bottomSheetOffset] for determining the position of the BottomSheet
/// relative to the upper border of the screen
/// [bottomSheetOffset] - percent of offset
///
typedef FlexibleDraggableScrollableWidgetBodyBuilder = SliverChildDelegate
    Function(
  BuildContext context,
  double bottomSheetOffset,
);

/// A container for a [Scrollable] that responds to drag gestures by resizing
/// the scrollable until a limit is reached, and then scrolling.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=Hgw819mL_78}
///
/// This widget can be dragged along the vertical axis between its
/// [minChildSize], which defaults to `0.25` and [maxChildSize], which defaults
/// to `1.0`. These sizes are percentages of the height of the parent container.
///
/// The widget coordinates resizing and scrolling of the widget returned by
/// builder as the user drags along the horizontal axis.
///
/// The widget will initially be displayed at its initialChildSize which
/// defaults to `0.5`, meaning half the height of its parent. Dragging will work
/// between the range of minChildSize and maxChildSize (as percentages of the
/// parent container's height) as long as the builder creates a widget which
/// uses the provided [ScrollController]. If the widget created by the
/// [ScrollableWidgetBuilder] does not use the provided [ScrollController], the
/// sheet will remain at the initialChildSize.
///
/// By default, the widget will expand its non-occupied area to fill available
/// space in the parent. If this is not desired, e.g. because the parent wants
/// to position sheet based on the space it is taking, the [expand] property
/// may be set to false.
///
/// {@tool sample}
///
/// This is a sample widget which shows a [ListView] that has 25 [ListTile]s.
/// It starts out as taking up half the body of the [Scaffold], and can be
/// dragged up to the full height of the scaffold or down to 25% of the height
/// of the scaffold. Upon reaching full height, the list contents will be
/// scrolled up or down, until they reach the top of the list again and the user
/// drags the sheet back down.
///
/// ```dart
/// class HomePage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(
///         title: const Text('FlexibleDraggableScrollableSheet'),
///       ),
///       body: SizedBox.expand(
///         child: FlexibleDraggableScrollableSheet(
///         builder: (BuildContext context, ScrollController scrollController){
///             return Container(
///               color: Colors.blue[100],
///               child: ListView.builder(
///                 controller: scrollController,
///                 itemCount: 25,
///                 itemBuilder: (BuildContext context, int index) {
///                   return ListTile(title: Text('Item $index'));
///                 },
///               ),
///             );
///           },
///         ),
///       ),
///     );
///   }
/// }
/// ```
/// {@end-tool}
class FlexibleDraggableScrollableSheet extends StatefulWidget {
  /// Creates a widget that can be dragged and scrolled in a single gesture.
  ///
  /// The [builder], [initialChildSize], [minChildSize], [maxChildSize] and
  /// [expand] parameters must not be null.
  const FlexibleDraggableScrollableSheet({
    required this.builder,
    Key? key,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 1.0,
    this.expand = true,
  })  : assert(minChildSize >= 0.0),
        assert(maxChildSize <= 1.0),
        assert(minChildSize <= initialChildSize),
        assert(initialChildSize <= maxChildSize),
        super(key: key);

  /// The initial fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `0.5`.
  final double initialChildSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `0.25`.
  final double minChildSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `1.0`.
  final double maxChildSize;

  /// Whether the widget should expand to fill the available space in its parent
  /// or not.
  ///
  /// In most cases, this should be true. However, in the case of a parent
  /// widget that will position this one based on its desired size (such as a
  /// [Center]), this should be set to false.
  ///
  /// The default value is true.
  final bool expand;

  /// The builder that creates a child to display in this widget, which will
  /// use the provided [ScrollController] to enable dragging and scrolling
  /// of the contents.
  final ScrollableWidgetBuilder builder;

  @override
  _FlexibleDraggableScrollableSheetState createState() =>
      _FlexibleDraggableScrollableSheetState();
}

/// A [Notification] related to the extent, which is the size, and scroll
/// offset, which is the position of the child list, of the
/// [FlexibleDraggableScrollableSheet].
///
/// [FlexibleDraggableScrollableSheet] widgets notify their ancestors when the
/// size of
/// the sheet changes. When the extent of the sheet changes via a drag,
/// this notification bubbles up through the tree, which means a given
/// [NotificationListener] will receive notifications for all descendant
/// [FlexibleDraggableScrollableSheet] widgets. To focus on notifications
/// from the
/// nearest FlexibleDraggableScrollableSheet descendant, check that the
/// [depth]
/// property of the notification is zero.
///
/// When an extent notification is received by a [NotificationListener], the
/// listener will already have completed build and layout, and it is therefore
/// too late for that widget to call [State.setState]. Any attempt to adjust the
/// build or layout based on an extent notification would result in a layout
/// that lagged one frame behind, which is a poor user experience. Extent
/// notifications are used primarily to drive animations. The [Scaffold] widget
/// listens for extent notifications and responds by driving animations for the
/// [FloatingActionButton] as the bottom sheet scrolls up.
class FlexibleDraggableScrollableNotification extends Notification
    with ViewportNotificationMixin {
  /// Creates a notification that the extent of a
  /// [FlexibleDraggableScrollableSheet] has
  /// changed.
  ///
  /// All parameters are required. The [minExtent] must be >= 0. The [maxExtent]
  /// must be <= 1.0.  The [extent] must be between [minExtent] and [maxExtent].
  FlexibleDraggableScrollableNotification({
    required this.extent,
    required this.minExtent,
    required this.maxExtent,
    required this.initialExtent,
    this.context,
  })  : assert(0.0 <= minExtent),
        assert(maxExtent <= 1.0),
        assert(minExtent <= extent),
        assert(minExtent <= initialExtent),
        assert(extent <= maxExtent),
        assert(initialExtent <= maxExtent);

  /// The current value of the extent, between [minExtent] and [maxExtent].
  final double extent;

  /// The minimum value of [extent], which is >= 0.
  final double minExtent;

  /// The maximum value of [extent].
  final double maxExtent;

  /// The initially requested value for [extent].
  final double initialExtent;

  /// The build context of the widget that fired this notification.
  ///
  /// This can be used to find the sheet's render objects to determine the size
  /// of the viewport, for instance. A listener can only assume this context
  /// is live when it first gets the notification.
  final BuildContext? context;

  @override
  void debugFillDescription(List<String> description) {
    super.debugFillDescription(description);
    description.add('minExtent: $minExtent, extent: $extent, '
        'maxExtent: $maxExtent, initialExtent: $initialExtent');
  }
}

/// Manages state between [_FlexibleDraggableScrollableSheetState],
/// [FlexibleDraggableScrollableSheetScrollController], and
/// [_FlexibleDraggableScrollableSheetScrollPosition].
///
/// The State knows the pixels available along the axis the widget wants to
/// scroll, but expects to get a fraction of those pixels to render the sheet.
///
///The ScrollPosition knows the number of pixels a user wants to move the sheet.
///
/// The [currentExtent] will never be null.
/// The [availablePixels] will never be null, but may be `double.infinity`.
class FlexibleDraggableSheetExtent {
  FlexibleDraggableSheetExtent({
    required this.minExtent,
    required this.maxExtent,
    required this.initialExtent,
    required VoidCallback listener,
  })  : assert(minExtent >= 0),
        assert(maxExtent <= 1),
        assert(minExtent <= initialExtent),
        assert(initialExtent <= maxExtent),
        _currentExtent = ValueNotifier<double>(initialExtent)
          ..addListener(listener),
        availablePixels = double.infinity;

  final double minExtent;
  final double maxExtent;
  final double initialExtent;
  final ValueNotifier<double> _currentExtent;
  double availablePixels;

  bool get isAtMin => minExtent >= _currentExtent.value;

  bool get isAtMax => maxExtent <= _currentExtent.value;

  set currentExtent(double value) =>
      _currentExtent.value = value.clamp(minExtent, maxExtent);

  double get currentExtent => _currentExtent.value;

  double get additionalMinExtent => isAtMin ? 0.0 : 1.0;

  double get additionalMaxExtent => isAtMax ? 0.0 : 1.0;

  /// The scroll position gets inputs in terms of pixels, but the extent is
  /// expected to be expressed as a number between 0..1.
  void addPixelDelta(double delta, BuildContext? context) {
    if (availablePixels == 0) {
      return;
    }
    currentExtent += delta / availablePixels * maxExtent;
    FlexibleDraggableScrollableNotification(
      minExtent: minExtent,
      maxExtent: maxExtent,
      extent: currentExtent,
      initialExtent: initialExtent,
      context: context,
    ).dispatch(context);
  }
}

class _FlexibleDraggableScrollableSheetState
    extends State<FlexibleDraggableScrollableSheet> {
  late FlexibleDraggableScrollableSheetScrollController _scrollController;
  late FlexibleDraggableSheetExtent _extent;

  @override
  void initState() {
    super.initState();
    _extent = FlexibleDraggableSheetExtent(
      minExtent: widget.minChildSize,
      maxExtent: widget.maxChildSize,
      initialExtent: widget.initialChildSize,
      listener: _setExtent,
    );
    _scrollController =
        FlexibleDraggableScrollableSheetScrollController(extent: _extent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_InheritedResetNotifier.shouldReset(context)) {
      // jumpTo can result in trying to replace semantics during build.
      // Just animate really fast.
      // Avoid doing it at all if the offset is already 0.0.
      if (_scrollController.offset != 0.0) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 1),
          curve: Curves.linear,
        );
      }
      _extent._currentExtent.value = _extent.initialExtent;
    }
  }

  void _setExtent() {
    setState(() {
      // _extent has been updated when this is called.
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _extent.availablePixels =
            widget.maxChildSize * constraints.biggest.height;
        final Widget sheet = FractionallySizedBox(
          heightFactor: _extent.currentExtent,
          alignment: Alignment.bottomCenter,
          child: widget.builder(context, _scrollController),
        );
        return widget.expand ? SizedBox.expand(child: sheet) : sheet;
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

/// A [ScrollController] suitable for use in a [ScrollableWidgetBuilder] created
/// by a [FlexibleDraggableScrollableSheet].
///
/// If a [FlexibleDraggableScrollableSheet] contains content that is exceeds
/// the height
/// of its container, this controller will allow the sheet to both be dragged to
/// fill the container and then scroll the child content.
///
/// See also:
///
///  * [_FlexibleDraggableScrollableSheetScrollPosition], which manages the
/// positioning logic for
///    this controller.
///  * [PrimaryScrollController], which can be used to establish a
///    [_FlexibleDraggableScrollableSheetScrollController] as the primary
/// controller for
///    descendants.
class FlexibleDraggableScrollableSheetScrollController
    extends ScrollController {
  FlexibleDraggableScrollableSheetScrollController({
    required this.extent,
    double initialScrollOffset = 0.0,
    String? debugLabel,
  }) : super(
          debugLabel: debugLabel,
          initialScrollOffset: initialScrollOffset,
        );

  final FlexibleDraggableSheetExtent extent;

  @override
  _FlexibleDraggableScrollableSheetScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _FlexibleDraggableScrollableSheetScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      extent: extent,
    );
  }

  @override
  void debugFillDescription(List<String> description) {
    super.debugFillDescription(description);
    description.add('extent: $extent');
  }
}

/// A scroll position that manages scroll activities for
/// [FlexibleDraggableScrollableSheetScrollController].
///
/// This class is a concrete subclass of [ScrollPosition] logic that handles a
/// single [ScrollContext], such as a [Scrollable]. An instance of this class
/// manages [ScrollActivity] instances, which changes the
/// [FlexibleDraggableSheetExtent.currentExtent] or visible content offset in
/// the [Scrollable]'s [Viewport]
///
/// See also:
///
///  * [FlexibleDraggableScrollableSheetScrollController], which uses this as
/// its [ScrollPosition].
class _FlexibleDraggableScrollableSheetScrollPosition
    extends ScrollPositionWithSingleContext {
  _FlexibleDraggableScrollableSheetScrollPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    required this.extent,
    double initialPixels = 0.0,
    bool keepScrollOffset = true,
    ScrollPosition? oldPosition,
    String? debugLabel,
  }) : super(
          physics: physics,
          context: context,
          initialPixels: initialPixels,
          keepScrollOffset: keepScrollOffset,
          oldPosition: oldPosition,
          debugLabel: debugLabel,
        );

  VoidCallback? _dragCancelCallback;
  final FlexibleDraggableSheetExtent extent;

  bool get listShouldScroll => pixels > 0.0;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    // We need to provide some extra extent if we haven't yet reached the max or
    // min extents. Otherwise, a list with fewer children than the extent of
    // the available space will get stuck.
    return super.applyContentDimensions(
      minScrollExtent - extent.additionalMinExtent,
      maxScrollExtent + extent.additionalMaxExtent,
    );
  }

  @override
  void applyUserOffset(double delta) {
    if (!listShouldScroll &&
        (!(extent.isAtMin || extent.isAtMax) ||
            (extent.isAtMin && delta < 0) ||
            (extent.isAtMax && delta > 0))) {
      extent.addPixelDelta(-delta, context.notificationContext);
    } else {
      super.applyUserOffset(delta);
    }
  }

  @override
  void goBallistic(double velocity) {
    if (velocity == 0.0 ||
        (velocity < 0.0 && listShouldScroll) ||
        (velocity > 0.0 && extent.isAtMax)) {
      super.goBallistic(velocity);
      return;
    }
    //Scrollable expects that we will dispose of its current _dragCancelCallback
    _dragCancelCallback?.call();
    _dragCancelCallback = null;

    // The iOS bouncing simulation just isn't right here - once we delegate
    // the ballistic back to the ScrollView, it will use the right simulation.
    final Simulation simulation = ClampingScrollSimulation(
      position: extent.currentExtent,
      velocity: velocity,
      tolerance: physics.tolerance,
    );

    final ballisticController = AnimationController.unbounded(
      debugLabel: '_FlexibleDraggableScrollableSheetScrollPosition',
      vsync: context.vsync,
    );
    var lastDelta = 0.0;
    void _tick() {
      final delta = ballisticController.value - lastDelta;
      lastDelta = ballisticController.value;
      extent.addPixelDelta(delta, context.notificationContext);
      if ((velocity > 0 && extent.isAtMax) ||
          (velocity < 0 && extent.isAtMin)) {
        // Make sure we pass along enough velocity to keep scrolling - otherwise
        // we just "bounce" off the top making it look like the list doesn't
        // have more to scroll.
        // ignore: parameter_assignments
        velocity = ballisticController.velocity +
            (physics.tolerance.velocity * ballisticController.velocity.sign);
        super.goBallistic(velocity);
        ballisticController.stop();
      } else if (ballisticController.isCompleted) {
        super.goBallistic(0);
      }
    }

    ballisticController
      ..addListener(_tick)
      ..animateWith(simulation).whenCompleteOrCancel(
        ballisticController.dispose,
      );
  }

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    // Save this so we can call it later if we have to [goBallistic] on our own.
    _dragCancelCallback = dragCancelCallback;
    return super.drag(details, dragCancelCallback);
  }
}

/// A widget that can notify a descendent [FlexibleDraggableScrollableSheet]
/// that it should reset its position to the initial state.
///
/// The [Scaffold] uses this widget to notify a persistent bottom sheet that
/// the user has tapped back if the sheet has started to cover more of the body
/// than when at its initial position. This is important for users of assistive
/// technology, where dragging may be difficult to communicate.
class FlexibleDraggableScrollableActuator extends StatelessWidget {
  /// Creates a widget that can notify descendent
  /// [FlexibleDraggableScrollableSheet]s to reset to their initial position.
  ///
  /// The [child] parameter is required.
  FlexibleDraggableScrollableActuator({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// This child's [FlexibleDraggableScrollableSheet] descendant will be reset
  /// when the [reset] method is applied to a context that includes it.
  ///
  /// Must not be null.
  final Widget child;

  final _ResetNotifier _notifier = _ResetNotifier();

  /// Notifies any descendant [FlexibleDraggableScrollableSheet] that it should
  /// reset to its initial position.
  ///
  /// Returns `true` if a [FlexibleDraggableScrollableActuator] is available and
  /// some [FlexibleDraggableScrollableSheet] is listening for updates, `false`
  /// otherwise.
  static bool reset(BuildContext context) {
    final notifier =
        context.dependOnInheritedWidgetOfExactType<_InheritedResetNotifier>();
    if (notifier == null) {
      return false;
    }
    return notifier._sendReset();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedResetNotifier(
      notifier: _notifier,
      child: child,
    );
  }
}

/// A [ChangeNotifier] to use with InheritedResetNotifyer to notify
/// descendants that they should reset to initial state.
class _ResetNotifier extends ChangeNotifier {
  /// Whether someone called [sendReset] or not.
  ///
  /// This flag should be reset after checking it.
  bool _wasCalled = false;

  /// Fires a reset notification to descendants.
  ///
  /// Returns false if there are no listeners.
  bool sendReset() {
    if (!hasListeners) {
      return false;
    }
    _wasCalled = true;
    notifyListeners();
    return true;
  }
}

class _InheritedResetNotifier extends InheritedNotifier<_ResetNotifier> {
  /// Creates an [InheritedNotifier] that the
  /// [FlexibleDraggableScrollableSheet] will
  /// listen to for an indication that it should change its extent.
  ///
  /// The [child] and [notifier] properties must not be null.
  const _InheritedResetNotifier({
    required Widget child,
    required _ResetNotifier notifier,
    Key? key,
  }) : super(key: key, child: child, notifier: notifier);

  // use "!" because notifier is required in overload constructor
  bool _sendReset() => notifier!.sendReset();

  /// Specifies whether the [FlexibleDraggableScrollableSheet] should reset to
  /// its initial position.
  ///
  /// Returns true if the notifier requested a reset, false otherwise.
  static bool shouldReset(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedResetNotifier>();
    if (widget == null) {
      return false;
    }
    assert(widget is _InheritedResetNotifier);
    final inheritedNotifier = widget;
    if (inheritedNotifier.notifier != null) {
      final wasCalled = inheritedNotifier.notifier!._wasCalled;
      inheritedNotifier.notifier!._wasCalled = false;
      return wasCalled;
    } else {
      return false;
    }
  }
}
