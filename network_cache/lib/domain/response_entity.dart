/// Cached data representation
/// with some additional info like recording time.
class ResponseEntity {
  final Map<String, dynamic> data;
  final Duration lifetime;
  final DateTime storageTimestamp;

  ResponseEntity({
    this.data,
    this.lifetime,
    this.storageTimestamp,
  });

  static ResponseEntity fromJson(Map<String, dynamic> json) {
    return ResponseEntity(
      data: Map<String, dynamic>.from(json['data']),
      lifetime: Duration(milliseconds: json['lifetime'] as int),
      storageTimestamp:
          DateTime.fromMillisecondsSinceEpoch(json['storageTimestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'lifetime': lifetime.inMilliseconds,
        'storageTimestamp': storageTimestamp.millisecondsSinceEpoch,
      };
}
