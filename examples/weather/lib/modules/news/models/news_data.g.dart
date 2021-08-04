// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsData _$NewsDataFromJson(Map<String, dynamic> json) {
  return NewsData(
    author: json['author'] as String? ?? '',
    title: json['title'] as String? ?? 'Untitled',
    description: json['description'] as String? ?? '',
    url: json['url'] as String? ?? 'https://google.com',
    source: json['source'] as String? ?? 'Source unknown',
    image: json['image'] as String? ?? '',
    category: json['category'] as String? ?? 'general',
    language: json['language'] as String? ?? '',
    country: json['country'] as String? ?? '',
    publishedAt: json['published_at'] as String? ?? '',
  );
}

Map<String, dynamic> _$NewsDataToJson(NewsData instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'source': instance.source,
      'image': instance.image,
      'category': instance.category,
      'language': instance.language,
      'country': instance.country,
      'published_at': instance.publishedAt,
    };
