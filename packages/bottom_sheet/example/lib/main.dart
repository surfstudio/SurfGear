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

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

// ignore_for_file: avoid-returning-widgets

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showSheet,
              child: const Text('Open BottomSheet'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showSheetWithoutList,
              child: const Text('Open StickyBottomSheet'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSheet() {
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      context: context,
      builder: _buildBottomSheet,
      anchors: [0, 0.5, 1],
    );
  }

  void _showSheetWithoutList() {
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: .8,
      headerHeight: 200,
      context: context,
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      headerBuilder: (context, offset) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
              topRight: Radius.circular(offset == 0.8 ? 0 : 40),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Header',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              Text(
                'position $offset',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        );
      },
      builder: (context, offset) {
        return SliverChildListDelegate(
          _getChildren(offset, isShowPosition: false),
        );
      },
      anchors: [.2, 0.5, .8],
    );
  }

  List<Widget> _getChildren(
    double bottomSheetOffset, {
    required bool isShowPosition,
  }) =>
      [
        if (isShowPosition)
          Text(
            'position $bottomSheetOffset',
            style: Theme.of(context).textTheme.headline6,
          ),
        _buildTextField(),
        _testContainer(const Color(0xEEFFFF00)),
        _buildTextField(),
        _testContainer(const Color(0xDD99FF00)),
        _buildTextField(),
        _testContainer(const Color(0xCC00FFFF)),
        _buildTextField(),
        _testContainer(const Color(0xBB555555)),
        _buildTextField(),
        _testContainer(const Color(0xAAFF5555)),
        _buildTextField(),
        _testContainer(const Color(0x9900FF00)),
        _buildTextField(),
        _testContainer(const Color(0x8800FF00)),
        _buildTextField(),
        _testContainer(const Color(0x7700FF00)),
        _buildTextField(),
      ];

  Widget _testContainer(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: color,
      ),
    );
  }

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            controller: scrollController,
            children: _getChildren(bottomSheetOffset, isShowPosition: true),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() => const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a search term',
        ),
      );
}
