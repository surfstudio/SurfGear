int parseInt(dynamic from) {
  if (from == null) return from;
  if (from is int) return from;
  if (from is String) return int.parse(from);
  if (from is double) return from.toInt();

  throw FormatException("can't parse to int");
}