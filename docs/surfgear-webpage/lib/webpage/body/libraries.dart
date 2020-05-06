import 'dart:convert';

import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/webpage/body/carousel/library_item.dart';

List<String> _librariesImages = [
  icLib1,
  icLib2,
  icLib2,
  icLib4,
  icLib5,
  icLib6,
];

List<String> getLibrariesList(String str) =>
    List<String>.from(json.decode(str).map((library) => library));

/// Generation of libraries list
/// This feature will allow you to add new libraries
/// to the carousel without recompiling the project
/// TODO сейчас список картинок статичен, поэтому его захардкодил
/// TODO в дальнейшем, если каждой библиотеки будет назначена своя иконка
/// TODO конфигурацию иконок можно так-же вынести в json
/// TODO и хранить в виде ключ-значение
/// TODO например {"lib_name":"image_path"}
List<LibraryItem> getLibraries(List<String> librariesNames) {
  List<LibraryItem> libraries = [];
  for (int i = 0, j = i; i < librariesNames.length; i++, j++) {
    libraries.add(
      LibraryItem(
        title: librariesNames[i],
        imagePath: _librariesImages[j],
      ),
    );
    if (j == _librariesImages.length - 1) {
      j = 0;
    }
  }
  return libraries;
}
