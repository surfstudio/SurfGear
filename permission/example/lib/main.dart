import 'package:flutter/material.dart';
import 'package:permission/base/exceptions.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/impl/default_permission_manager.dart';

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
  final PermissionManager _permissionManager = DefaultPermissionManager();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _requestPermission(Permission permission) async {
    try {
      final granted = await _permissionManager.request(
        permission,
        checkRationale: true,
      );

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(granted ? 'Permission granted' : 'Permission denied'),
        ),
      );
    } on FeatureProhibitedException catch (_) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('User prohibited this feature'),
              FlatButton(
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Text('Show settings'),
                onPressed: () => _permissionManager.openSettings(),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var permission in Permission.values)
              FlatButton(
                child: Text(permission.toString()),
                onPressed: () => _requestPermission(permission),
              )
          ],
        ),
      ),
    );
  }
}
