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

import 'package:build_context_holder/build_context_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  TestWidgetState createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget>
    with BuildContextHolderStateMixin<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestWidget title'),
      ),
    );
  }
}

void main() {
  testWidgets('Holder testing', (tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (context) {
          BuildContextHolder.instance.context = context;
          expect(context, BuildContextHolder.instance.context);
          return const Placeholder();
        },
      ),
    );
  });

  testWidgets('Mixin testing', (tester) async {
    BuildContextHolder.instance.context = null;
    await tester.pumpWidget(
      const MaterialApp(
        home: TestWidget(),
      ),
    );
    expect(BuildContextHolder.instance.context, isNotNull);
  });
}
