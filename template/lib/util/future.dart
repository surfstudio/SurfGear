class FutureUtils {
  ///Отсроченный запрос
  static Future delayed(Duration dur, [dynamic Function() computation]) {
    return Future.delayed(dur, computation);
  }
}
