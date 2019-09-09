/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/temp/ui/di/temp_screen_component.dart';
import 'package:flutter_template/temp/ui/temp_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// Экран <todo>
class TempScreen extends StatefulWidget {
  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState
    extends WidgetState<TempScreen, TempWidgetModel, TempScreenComponent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget buildState(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Text("temp screen"),
    );
  }

  @override
  TempScreenComponent getComponent(BuildContext context) {
    return TempScreenComponent(
      Injector.of<AppComponent>(context).component,
      _scaffoldKey,
      Navigator.of(context),
    );
  }
}
