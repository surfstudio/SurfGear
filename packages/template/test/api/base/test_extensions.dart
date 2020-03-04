import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

/// Утилиты для тестирования потоков данных

/// Проверка полученных из [Stream] данных на правду
void expectTrue(Stream<bool> request) => expect(request, emits(true));

/// Проверка полученных из [Stream] данных на null
void expectNotNull(Stream request) => expectTrue(request.map((r) => r != null));

/// Проверка полученного из [Stream] списка на пустоту
void expectNotEmpty(Stream<List> request) => expectTrue(request.map((r) => r.isNotEmpty));
