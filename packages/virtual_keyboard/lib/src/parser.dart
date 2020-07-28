int parseInt(Object from) {
  // ignore: avoid_returning_null
  if (from == null) return null;
  if (from is int) return from;
  if (from is String) return int.parse(from);
  if (from is double) return from.toInt();

  throw const FormatException("can't parse to int");
}
