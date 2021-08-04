// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    data: (json['data'] as List<dynamic>)
        .map((e) => NewsData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'pagination': instance.pagination.toJson(),
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
