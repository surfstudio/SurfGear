// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    limit: json['limit'] as int,
    offset: json['offset'] as int,
    count: json['count'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'count': instance.count,
      'total': instance.total,
    };
