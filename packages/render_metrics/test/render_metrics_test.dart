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
import 'package:render_metrics/render_metrics.dart';

import 'test_utils.dart';

void main() {
  group('RenderParametersManager', () {
    testWidgets('returns renderData', (tester) async {
      const box = SizedBox(height: 400, width: 800);

      const firstId = 'box';

      final renderManager = RenderParametersManager<String>();

      final object = RenderMetricsObject(
        id: firstId,
        manager: renderManager,
        child: box,
      );

      await tester.pumpWidget(makeTestableWidget(object));

      final renderData = renderManager.getRenderData('box');

      expect(renderData?.height, 400);
      expect(renderData?.width, 800);
    });

    testWidgets('calculates diff', (tester) async {
      const firstBox = SizedBox(height: 400, width: 800);
      const secondBox = SizedBox(height: 200, width: 400);

      const firstId = 'first';
      const secondId = 'second';

      final renderManager = RenderParametersManager<String>();

      final firstObject = RenderMetricsObject(
        id: firstId,
        manager: renderManager,
        child: firstBox,
      );
      final secondObject = RenderMetricsObject(
        id: secondId,
        manager: renderManager,
        child: secondBox,
      );

      await tester.pumpWidget(
        makeTestableWidget(Column(children: [firstObject, secondObject])),
      );

      final diff = renderManager.getDiffById(firstId, secondId);

      expect(diff?.height, equals(200));
      expect(diff?.width, equals(400));

      final firstRenderData = renderManager.getRenderData(firstId);
      final secondRenderData = renderManager.getRenderData(secondId);

      final diffUsingOperatior = firstRenderData! - secondRenderData!;

      expect(diffUsingOperatior.height, equals(200));
      expect(diffUsingOperatior.width, equals(400));
    });
  });
}
