import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';


void expectTrue(Observable<bool> request) => expect(request, emits(true));

void expectNotNull(Observable request) => expectTrue(request.map((r) => r != null));

void expectNotEmpty(Observable<List> request) => expectTrue(request.map((r) => r.isNotEmpty));
