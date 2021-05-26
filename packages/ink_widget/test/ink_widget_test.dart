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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_widget/src/disable_widget.dart';
import 'package:ink_widget/src/ink_widget.dart';

import 'utils.dart';

void main() {
  const defaultOpacity = 0.5;
  group('InkWidget builds', () {
    group('in disable state if passed active disable argument', () {
      testWidgets('with custom disable state arguments', (tester) async {
        const text = 'default InkWidget';
        const disableColor = Colors.green;
        const disableOpacity = 1.0;
        const shapeDecoration =
            ShapeDecoration(shape: Border(), color: Colors.yellow);
        const defaultDecorationShape = Border();

        await tester.pumpWidget(makeTestableWidget(InkWidget(
          onTap: () {},
          disable: true,
          disableColor: disableColor,
          disableOpacity: disableOpacity,
          shape: shapeDecoration,
          shapeBorder: defaultDecorationShape,
          child: const Text(text),
        )));

        final typeFinder = find.byWidgetPredicate((widget) =>
            widget is DisableWidget &&
            widget.color == disableColor &&
            widget.opacity == disableOpacity &&
            widget.decoration == shapeDecoration &&
            widget.defaultDecorationShape == defaultDecorationShape);

        expect(typeFinder, findsOneWidget);
      });

      testWidgets('without any disable state arguments', (tester) async {
        await tester.pumpWidget(makeTestableWidget(InkWidget(
          disable: true,
          child: const Text('ink'),
        )));

        final typeFinder = find.byWidgetPredicate((widget) =>
            widget is DisableWidget &&
            widget.color == Colors.black.withOpacity(defaultOpacity));

        expect(typeFinder, findsOneWidget);
      });

      testWidgets('with custom disabel widget', (tester) async {
        const color = Colors.white;
        const disableWidget =
            DisableWidget(color: color, opacity: defaultOpacity);

        await tester.pumpWidget(makeTestableWidget(InkWidget(
          disable: true,
          disableWidget: disableWidget,
          child: const Text('ink'),
        )));

        final typeFinder = find.byWidgetPredicate((widget) =>
            widget is DisableWidget &&
            widget.color == color &&
            widget.opacity == defaultOpacity);

        expect(typeFinder, findsOneWidget);
      });
    });

    group('with passed', () {
      testWidgets('only shapeBorder', (tester) async {
        final shapeBorder =
            Border.all(width: 2.0, color: const Color(0xFFFFFFFF));

        await tester.pumpWidget(makeTestableWidget(InkWidget(
          shapeBorder: shapeBorder,
          child: const Text('ink'),
        )));

        final typeFinder = find.byWidgetPredicate((widget) =>
            widget is InkWell && widget.customBorder == shapeBorder);

        expect(typeFinder, findsOneWidget);
      });

      testWidgets('only customBorder', (tester) async {
        final customBorder =
            Border.all(width: 2.0, color: const Color(0xFFFFFFFF));

        await tester.pumpWidget(makeTestableWidget(InkWidget(
          customBorder: customBorder,
          child: const Text('ink'),
        )));

        final typeFinder = find.byWidgetPredicate((widget) =>
            widget is InkWell && widget.customBorder == customBorder);

        expect(typeFinder, findsOneWidget);
      });
    });

    testWidgets('with passed child', (tester) async {
      await tester.pumpWidget(makeTestableWidget(InkWidget(
        child: const Text('ink'),
      )));
      expect(find.text('ink'), findsOneWidget);
    });

    testWidgets('with custom inkwell', (tester) async {
      const inkWell = InkWell();

      await tester.pumpWidget(makeTestableWidget(InkWidget(
        inkWellWidget: inkWell,
        child: const Text('ink'),
      )));

      final typeFinder = find.byWidgetPredicate(
        (widget) => widget is InkWell && widget == inkWell,
      );

      expect(typeFinder, findsOneWidget);
    });
    testWidgets('with default inkWell with custom arguments', (tester) async {
      final customBorder =
          Border.all(width: 2.0, color: const Color(0xFFFFFFFF));
      const color = Colors.black;
      const radius = 0.2;
      const borderRadius = BorderRadius.all(Radius.elliptical(5, 9));
      const enableFeedback = false;
      const excludeFromSemantics = true;
      const canRequestFocus = false;
      const autofocus = true;
      final focusNode = FocusNode();

      void onTap() {}
      void onDoubleTap() {}
      void onLongPress() {}
      void onTapDown(TapDownDetails _) {}
      void onTapCancel() {}
      // ignore: avoid_positional_boolean_parameters
      void onHighlightChanged(bool _) {}
      // ignore: avoid_positional_boolean_parameters
      void onHover(bool _) {}
      // ignore: avoid_positional_boolean_parameters
      void onFocusChange(bool _) {}

      final inkWidget = InkWidget(
        customBorder: customBorder,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onHighlightChanged: onHighlightChanged,
        onHover: onHover,
        focusColor: color,
        hoverColor: color,
        highlightColor: color,
        splashColor: color,
        radius: radius,
        borderRadius: borderRadius,
        enableFeedback: enableFeedback,
        excludeFromSemantics: excludeFromSemantics,
        focusNode: focusNode,
        canRequestFocus: canRequestFocus,
        onFocusChange: onFocusChange,
        autofocus: autofocus,
        child: const Text('ink'),
      );

      await tester.pumpWidget(makeTestableWidget(inkWidget));

      final typeFinder = find.byWidgetPredicate((widget) =>
          widget is InkWell &&
          widget.customBorder == customBorder &&
          widget.onTap == onTap &&
          widget.onDoubleTap == onDoubleTap &&
          widget.onLongPress == onLongPress &&
          widget.onTapDown == onTapDown &&
          widget.onTapCancel == onTapCancel &&
          widget.onHighlightChanged == onHighlightChanged &&
          widget.onHover == onHover &&
          widget.focusColor == color &&
          widget.hoverColor == color &&
          widget.highlightColor == color &&
          widget.splashColor == color &&
          widget.radius == radius &&
          widget.borderRadius == borderRadius &&
          widget.enableFeedback == enableFeedback &&
          widget.excludeFromSemantics == excludeFromSemantics &&
          widget.focusNode == focusNode &&
          widget.canRequestFocus == canRequestFocus &&
          widget.onFocusChange == onFocusChange &&
          widget.autofocus == autofocus);

      expect(typeFinder, findsOneWidget);
    });
  });
}
