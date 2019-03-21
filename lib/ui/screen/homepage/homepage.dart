import 'package:flutter/material.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/random_name/user_interactor.dart';
import 'package:flutter_template/ui/base/action.dart';
import 'package:flutter_template/ui/base/state.dart';
import 'package:flutter_template/ui/base/view_model.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:flutter_template/ui/res/strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

///Модель виджета [MyHomePage]
class HomePageModel extends WidgetModel {
  final CounterInteractor _counterInteractor;
  final UserInteractor _userInteractor;

  BehaviorSubject<int> counterSubject;
  BehaviorSubject<UserState> userStateSubject;

  Action incrementAction;

  HomePageModel(this._counterInteractor, this._userInteractor) {
    counterSubject = createSubject();
    userStateSubject = createSubject();
    _counterInteractor.counterObservable
        .listen((c) => counterSubject.add(c.count));

    counterSubject.listen(_loadRandomName);

    incrementAction = createAction();
    incrementAction.action.listen((v) => incrementCounter());
  }

  void incrementCounter() {
    _counterInteractor.incrementCounter();
  }

  _loadRandomName(int i) async {
    print("DEV_INFO loadName $i");
    if (i.isEven) {
      userStateSubject.add(UserState.loading());
      _userInteractor.getUser().then((user) {
        print("DEV_INFO $user");
        userStateSubject.add(UserState.none(user));
      }).catchError((e) {
        print("DEV_ERROR ${e.toString}");
        userStateSubject.add(UserState.error());
      });
    }
  }
}

class UserState extends EntityState<User> {
  UserState.error() : super.error();

  UserState.loading() : super.loading();

  UserState.none(User user) : super.none(user);
}

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
