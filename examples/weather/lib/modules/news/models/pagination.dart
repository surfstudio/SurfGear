import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  final int limit;
  final int offset;
  final int count;
  final int total;

  Pagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  String toString() {
    return 'Pagination(limit: $limit, offset: $offset, count: $count, total: $total)';
  }
}
