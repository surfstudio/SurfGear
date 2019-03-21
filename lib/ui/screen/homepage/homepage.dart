import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/user/user_interactor.dart';
import 'package:flutter_template/ui/base/widget_state.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:flutter_template/ui/res/strings.dart';
import 'package:flutter_template/ui/screen/homepage/homepage_wm.dart';

///Главная страница
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends WidgetState<MyHomePage, HomePageModel> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Injector(
      component: HomePageComponent(
        Injector.of(context).get(CounterInteractor),
        Injector.of(context).get(UserInteractor),
        _scaffoldState,
      ),
      builder: _buildPage,
    );
  }

  void showSnack() {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text("Snack with error"),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    model = Injector.of(context).get(HomePageModel);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: model.incrementAction.doAction,
        tooltip: incButtonTooltip,
        child: Icon(Icons.add),
      ),
    );
  }

  Center _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            homePageText,
          ),
          StreamBuilder<int>(
            stream: model.counterSubject,
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.display1,
              );
            },
          ),
          StreamBuilder<UserState>(
              stream: model.userStateSubject,
              initialData: UserState.loading(),
              builder: (ctx, snapshot) {
                if (snapshot.data.isLoading) {
                  return ProgressBar();
                } else if (snapshot.data.hasError) {
                  return Text("Some errors");
                } else {
                  return Text(snapshot.data.data.name);
                }
              }),
        ],
      ),
    );
  }
}
