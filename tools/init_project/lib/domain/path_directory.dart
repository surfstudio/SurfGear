/// Хранит путь до папки проекта и папки с временными данными
///
/// Сделан для удобства, чтобы не возиться с Directory().parent или передачами 2-х Directory
class PathDirectory {
  String path;
  String pathTemp;
}
