import 'package:flutter_test/flutter_test.dart';
import 'package:mwwm_example/features/home/data/models/home_data_model.dart';
import 'package:mwwm_example/features/home/data/models/post_model.dart';

void main() {
  const tHomeDataModel = HomeDataModel(posts: [
    PostModel(title: 'title', description: 'description', id: 1),
  ]);

  test('Should parse json to homeDataModel', () async {
    final result = HomeDataModel.fromJson(const <dynamic>[
      <String, dynamic>{
        'title': 'title',
        'description': 'description',
        'id': 1,
      },
    ]);

    expect(tHomeDataModel, result);
  });
}
