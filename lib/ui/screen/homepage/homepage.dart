import 'package:flutter/material.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


abstract class ViewModel {

  List<Subject> _subjects = List();

  BehaviorSubject<T> createSubject<T>() {
    BehaviorSubject<T> bs = BehaviorSubject<T>();
    _subjects.add(bs);
    return bs;
  }

  dispose() {
    _subjects.forEach(
      (s) => s.close()
    );
  }

}
class HomePageModel extends ViewModel {
  int _counter = 0;

  BehaviorSubject<int> _counterSubject = BehaviorSubject<int>();
  BehaviorSubject<String> _buttonTextSubject = BehaviorSubject<String>();

  Observable<int> get counterObservable => _counterSubject.stream;

  incrementCounter() {
    _counterSubject.add(_counter++);
  }

  dispose() {
    _counterSubject.close();
    _buttonTextSubject.close();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  HomePageModel _model = HomePageModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
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
            ProgressBar(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _model.incrementCounter(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
