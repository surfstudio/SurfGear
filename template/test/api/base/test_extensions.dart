

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

/// Утилиты для тестирования потоков данных

/// Проверка полученных из [Observable] данных на правду
void expectTrue(Observable<bool> request) => expect(request, emits(true));

/// Проверка полученных из [Observable] данных на null
void expectNotNull(Observable request) => expectTrue(request.map((r) => r != null));

/// Проверка полученного из [Observable] списка на пустоту
void expectNotEmpty(Observable<List> request) => expectTrue(request.map((r) => r.isNotEmpty));
