import 'package:flutter/material.dart';
import 'package:ink_widget/ink_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkWidget example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'InkWidget example'),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWidget(
              onTap: () {},
              child: Text('default InkWidget'),
              splashColor: Colors.green,
            ),
            const SizedBox(height: 20),
            InkWidget(
              disable: true,
              onTap: () {},
              child: Text('disable InkWidget'),
            ),
            const SizedBox(height: 20),
            InkWidget(
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Text('Container with BoxDecoration'),
              ),
            ),
            const SizedBox(height: 20),
            InkWidget(
              onTap: () {},
              child: Text('Custom InkWell (see code)'),
              inkWellWidget: InkWell(onTap: () {}),
            ),
            const SizedBox(height: 20),
            InkWidget(
              disable: true,
              onTap: () {},
              child: Text('Custom disableWidget (see code)'),
              disableWidget: Container(
                height: 50,
                color: Colors.white.withOpacity(.2),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('text in disableWidget'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
