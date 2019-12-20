import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFFFF0000),
        ),
      ),
      floatingActionButton: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: _showSheet,
                  child: SizedBox.expand(
                    child: Center(child: Text('1')),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _onTapWithoutList,
                  child: SizedBox.expand(
                    child: Center(child: Text('2')),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  List<Widget> _getChildren(double bottomSheetOffset) => <Widget>[
        Text("$bottomSheetOffset"),
        _buildTextField(),
        _testContainer(Color(0xEEFFFF00)),
        _buildTextField(),
        _testContainer(Color(0xDD99FF00)),
        _buildTextField(),
        _testContainer(Color(0xCC00FFFF)),
        _buildTextField(),
        _testContainer(Color(0xBB555555)),
        _buildTextField(),
        _testContainer(Color(0xAAFF5555)),
        _buildTextField(),
        _testContainer(Color(0x9900FF00)),
        _buildTextField(),
        _testContainer(Color(0x8800FF00)),
        _buildTextField(),
        _testContainer(Color(0x7700FF00)),
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

  void _showSheet() {
    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      context: context,
      builder: _buildBottomSheet,
      anchors: [0, 0.5, 1],
    );
  }

  void _onTapWithoutList() {
    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      context: context,
      builderHeader: (BuildContext context, double offset) {
        return Container(
          width: double.infinity,
          child: Text('Заголовок'),
        );
      },
      builderBody: (BuildContext context, double offset) {
        return SliverChildListDelegate(
          _getChildren(offset),
        );
      },
      anchors: [0, 0.5, 1],
    );
  }

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView(
              padding: EdgeInsets.all(0),
              controller: scrollController,
              children: _getChildren(bottomSheetOffset)),
        ),
      ),
    );
  }

  Widget _buildTextField() => TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a search term',
        ),
      );
}
