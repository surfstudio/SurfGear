import 'package:flutter_template/interactor/base/transformable.dart';

/// Базовая модель респонса для ответов вида: { data: [] }
/// [D] - доменный тип, [T] - Obj
abstract class DataResponse<D, T extends Transformable<D>>
    extends Transformable<List<D>> {
  List<T> _innerData;

  DataResponse.fromJson(Map<String, dynamic> json) {
    var response = json['data'];
    if (response == null) return;

    _innerData = response.map<T>((json) => mapFromJson(json)).toList();
  }

  T mapFromJson(dynamic json);

  @override
  List<D> transform() => _innerData.map<D>((data) => data.transform()).toList();
}
