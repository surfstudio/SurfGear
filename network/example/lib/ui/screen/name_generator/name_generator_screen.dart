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
