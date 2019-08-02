import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:name_generator/domain/User.dart';
import 'package:name_generator/ui/app/di/app.dart';
import 'package:name_generator/ui/res/text_styles.dart';
import 'package:name_generator/ui/screen/name_generator/di/name_generator.dart';
import 'package:name_generator/ui/screen/name_generator/name_generator_wm.dart';

/// Widget для экрана счетчика
class NameGeneratorScreen extends StatefulWidget {
  @override
  _NameGeneratorScreenState createState() => _NameGeneratorScreenState();
}

class _NameGeneratorScreenState extends WidgetState<NameGeneratorScreen,
    NameGeneratorWidgetModel, NameGeneratorComponent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget buildState(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Counter Demo'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.getUserAction,
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

  @override
  NameGeneratorComponent getComponent(BuildContext context) {
    /// получение зависимостей
    return NameGeneratorComponent(
      Injector.of<AppComponent>(context).component,
      Navigator.of(context),
    );
  }

  Widget _buildListWidget(
      BuildContext context, AsyncSnapshot<List<User>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        var user = snapshot.data[index];
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
