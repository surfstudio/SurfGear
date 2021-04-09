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

import 'package:counter/ui/app/app_wm.dart';
import 'package:counter/ui/app/di/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_injector/surf_injector.dart';

/// Widget of application
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  late AppWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return Injector<AppComponent>(
      component: AppComponent(navigatorKey),
      builder: (context) {
        wm = Injector.of<AppComponent>(context).component.wm;
        return _buildState(context);
      },
    );
  }

  Widget _buildState(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const Scaffold(
        body: Center(
          child: Icon(
            Icons.plus_one,
            size: 200,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
