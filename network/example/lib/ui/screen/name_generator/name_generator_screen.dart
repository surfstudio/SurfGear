import 'package:flutter/material.dart';
import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:name_generator/ui/res/text_styles.dart';
import 'package:name_generator/ui/screen/name_generator/name_generator_wm.dart';

/// Widget для экрана счетчика
class NameGeneratorScreen extends StatefulWidget {
  @override
  _NameGeneratorScreenState createState() => _NameGeneratorScreenState();

  static const String routeName = 'name_generator';

  final NameGeneratorInteractor interactor;

  NameGeneratorScreen(this.interactor);
}

class _NameGeneratorScreenState extends State<NameGeneratorScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  NameGeneratorWidgetModel wm;

  @override
  void initState() {
    wm = NameGeneratorWidgetModel(widget.interactor);
    super.initState();
  }

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Counter Demo'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          wm.getUserAction.add(true);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<List<User>>(
      stream: wm.listState.stream,
      initialData: [],
      builder: _buildListWidget,
    );
  }

  Widget _buildListWidget(
      BuildContext context, AsyncSnapshot<List<User>> snapshot) {
    return ListView.builder(
      itemCount: snapshot._data.length,
      itemBuilder: (context, index) {
        var user = snapshot._data[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(user.name, style: textRegular16),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Region: ${user.region}'),
                Text('Phone: ${user.phone}'),
                Text('Email: ${user.email}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
