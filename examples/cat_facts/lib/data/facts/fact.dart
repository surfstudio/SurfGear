class Fact {
  const Fact({
    this.status,
    this.type,
    this.deleted,
    this.id,
    this.user,
    this.text,
    this.v,
    this.source,
    this.updatedAt,
    this.createdAt,
    this.used,
  });

  factory Fact.fromJson(Map<String, dynamic> json) => Fact(
        status: Status.fromJson(json['status'] as Map<String, dynamic>),
        type: json['type'] as String?,
        deleted: json['deleted'] as bool?,
        id: json['_id'] as String?,
        user: json['user'] as String?,
        text: json['text'] as String?,
        v: json['__v'] as int?,
        source: json['source'] as String?,
        updatedAt: json['updatedAt'] as String?,
        createdAt: json['createdAt'] as String?,
        used: json['used'] as bool?,
      );

  final Status? status;
  final String? type;
  final bool? deleted;
  final String? id;
  final String? user;
  final String? text;
  final int? v;
  final String? source;
  final String? updatedAt;
  final String? createdAt;
  final bool? used;
}

class Status {
  const Status({
    this.verified,
    this.sentCount,
    this.feedback,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        verified: json['verified'] as bool?,
        sentCount: json['sentCount'] as int?,
        feedback: json['feedback'] as String?,
      );

  final bool? verified;
  final int? sentCount;
  final String? feedback;
}
