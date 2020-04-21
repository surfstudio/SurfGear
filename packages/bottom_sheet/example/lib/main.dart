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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: _showSheet,
              child: Text("Open BottomSheet"),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: _showSheetWithoutList,
              child: Text("Open StickyBottomSheet"),
            ),
          ],
        ),
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

  void _showSheetWithoutList() {
    showStickyFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: .8,
      headerHeight: 200,
      context: context,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(40.0),
          topRight: const Radius.circular(40.0),
        ),
      ),
      headerBuilder: (BuildContext context, double offset) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
              topRight: Radius.circular(offset == 0.8 ? 0 : 40),
            ),
          ),
          child: Text('Заголовок', style: TextStyle(color: Colors.black)),
        );
      },
      builder: (BuildContext context, double offset) {
        return SliverChildListDelegate(
          _getChildren(offset),
        );
      },
      anchors: [.2, 0.5, .8],
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

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return SafeArea(
      child: Material(
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
