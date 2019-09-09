class Notification {
  final DateTime date;
  final String title;
  final String text;
  final NotificationType type;

  Notification({
    this.date,
    this.title,
    this.text,
    String type,
  }) : type = _mapToType(type);
}

enum NotificationType { type1, type2 }

NotificationType _mapToType(String type) {
  switch (type) {
    case "type1":
      return NotificationType.type1;

    case "type2":
    default:
      return NotificationType.type2;
  }
}
