import 'package:flutter/material.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/interactor/random_name/user_interactor.dart';
import 'package:flutter_template/ui/base/state.dart';
import 'package:flutter_template/ui/base/view_model.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:flutter_template/ui/res/strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

///Модель виджета [MyHomePage]
class HomePageModel extends ViewModel {
  final CounterInteractor _counterInteractor;
  final UserInteractor _userInteractor;

  BehaviorSubject<int> _counterSubject;
  BehaviorSubject<UserState> _userNameSubject;

  Observable<int> get counterObservable => _counterSubject.stream;

  Observable<UserState> get userStateObservable => _userNameSubject.stream;

  HomePageModel(this._counterInteractor, this._userInteractor) {
    _counterSubject = createSubject();
    _userNameSubject = createSubject();
    _counterInteractor.counterObservable
        .listen((c) => _counterSubject.add(c.count));

    _counterSubject.listen(_loadRandomName);
  }

  incrementCounter() {
    _counterInteractor.incrementCounter();
  }

  _loadRandomName(int i) async {
    if (i.isEven) {
      _userNameSubject.add(UserState.loading());
      User user = await _userInteractor.getUser();
      print("DEV_INFO $user");
      //todo error handling
      _userNameSubject.add(UserState.none(user));
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  homePageText,
                ),
                StreamBuilder<int>(
                  stream: _model.counterObservable,
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),
                StreamBuilder<UserState>(
                    stream: _model.userStateObservable,
                    initialData: UserState.loading(),
                    builder: (context, snapshot) {
                      if (snapshot.data.isLoading) {
                        return ProgressBar();
                      } else {
                        return Text(snapshot.data.data.name);
                      }
                    }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _model.incrementCounter,
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
