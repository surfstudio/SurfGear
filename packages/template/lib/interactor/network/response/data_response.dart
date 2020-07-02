import 'package:flutter_template/interactor/base/transformable.dart';
import 'package:flutter_template/util/extensions.dart';

/// Базовая модель Response для ответов вида: { data: [] }
/// [D] - доменный тип, [T] - Obj
abstract class DataResponse<D, T extends Transformable<D>>
    extends Transformable<List<D>> {
  List<T> _innerData;

  DataResponse.fromJson(Map<String, dynamic> json) {
    final response = json.get<List<dynamic>>('data');
    if (response == null) return;

    _innerData = response.map<T>(mapFromJson).toList();
  }

  T mapFromJson(json);

  @override
  List<D> transform() => _innerData.map<D>((data) => data.transform()).toList();
}
