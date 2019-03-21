import 'package:flutter/material.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/user/user_interactor.dart';
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

class _HomePageState extends State<MyHomePage> {
  HomePageModel _model;

  @override
  Widget build(BuildContext context) {
    return Injector(
      component: HomePageComponent(
        Injector.of(context).get(CounterInteractor),
        Injector.of(context).get(UserInteractor),
      ),
      builder: (context) {
        _model = Injector.of(context).get(HomePageModel);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Builder(
            builder: (ctx) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      homePageText,
                    ),
                    StreamBuilder<int>(
                      stream: _model.counterSubject,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data}',
                          style: Theme.of(context).textTheme.display1,
                        );
                      },
                    ),
                    StreamBuilder<UserState>(
                        stream: _model.userStateSubject,
                        initialData: UserState.loading(),
                        builder: (ctx, snapshot) {
                          if (snapshot.data.isLoading) {
                            return ProgressBar();
                          } else if (snapshot.data.hasError) {
                            //todo сделать вменяемый показ снеков
                            /* Scaffold.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text("Snack with error"),
                              ),
                            );*/
                            return Text("Some errors");
                          } else {
                            return Text(snapshot.data.data.name);
                          }
                        }),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _model.incrementAction.doAction,
            tooltip: incButtonTooltip,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}
