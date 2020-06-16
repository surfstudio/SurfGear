//import 'scenario.dart';
//import 'step.dart';
//
//void main() {
//  Test();
//}
//
//class Test {
//  Test() {
//    _init();
//  }
//
//  void _init() {
//    print('init');
//    FutureScenario<String>(
//      Future.delayed(Duration(seconds: 1)).then((value) => 'Данные')
//    )
//    .onData((String data) => print(data))
//    .onStart(_handleStart)
//    .onError(_handleError)
//    .addSep(LoadCompleteStep(), ((_) => print('loadComplete')))
//    .addSep(
//      RequestStep(),
//      _handleRequest,
//    )
//    .addSep(
//      RequestStep().ifDo((data) {
//        print('ifDo');
//      })
//    )
//    .addSep(PredicateStep((_) async => true), (_) => print('lastStep'));
//  }
//
//  void _handleStart() {
//    print('start');
//  }
//
//  void _handleError(Error e) {
//    print('error: $e');
//  }
//
//  void _handleRequest(data) {
//    print('_handleRequest $data');
//  }
//}