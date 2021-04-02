class Fact {
  final Status status;
  final String type;
  final bool deleted;
  final String id;
  final String user;
  final String text;
  final int v;
  final String source;
  final String updatedAt;
  final String createdAt;
  final bool used;

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
        status: Status.fromJson(json['status']),
        type: json['type'],
        deleted: json['deleted'],
        id: json['_id'],
        user: json['user'],
        text: json['text'],
        v: json['__v'],
        source: json['source'],
        updatedAt: json['updatedAt'],
        createdAt: json['createdAt'],
        used: json['used'],
      );
}

class Status {
  final bool verified;
  final int sentCount;
  final String feedback;

  const Status({
    this.verified,
    this.sentCount,
    this.feedback,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        verified: json['verified'],
        sentCount: json['sentCount'],
        feedback: json['feedback'],
      );
}
