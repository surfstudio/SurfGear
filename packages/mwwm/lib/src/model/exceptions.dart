import 'package:mwwm/src/model/changes/changes.dart';

/// Not found any performer for change
class NoPerformerException implements Exception {
  final Change change;

  NoPerformerException(this.change);

  @override
  String toString() {
    return "No performer found for $change";
  }
}

/// Not found Broadcast for this Change
class NoBroadcastPerformerException implements Exception {
  final Type change;

  NoBroadcastPerformerException(this.change);

  @override
  String toString() {
    return "No broadcast found for $change";
  }
}
