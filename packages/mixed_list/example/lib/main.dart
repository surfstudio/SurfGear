import 'package:example/pagination_mixed_list_demo.dart';
import 'package:flutter/material.dart';

import 'midex_list_demo.dart';

void main() => runApp(MixedListDemoApp());

class MixedListDemoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MixedListDemoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Mixed list demo app"),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Mixed List Demo"),
                  Tab(text: "Pagination Mixed List Demo"),
                ],
              )),
          body: TabBarView(children: [
            MixedListDemo(),
            PaginationMixedListDemo(),
          ]),
        ));
  }
}
