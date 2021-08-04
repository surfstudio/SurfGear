import 'package:json_annotation/json_annotation.dart';

part 'news_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NewsData {
  @JsonKey(defaultValue: '')
  final String author;

  @JsonKey(defaultValue: 'Untitled')
  final String title;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: 'https://google.com')
  final String url;

  @JsonKey(defaultValue: 'Source unknown')
  final String source;

  @JsonKey(defaultValue: '')
  final String image;

  @JsonKey(defaultValue: 'general')
  final String category;

  @JsonKey(defaultValue: '')
  final String language;

  @JsonKey(defaultValue: '')
  final String country;

  @JsonKey(defaultValue: '')
  final String publishedAt;

  NewsData({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    required this.image,
    required this.category,
    required this.language,
    required this.country,
    required this.publishedAt,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) =>
      _$NewsDataFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDataToJson(this);

  @override
  String toString() {
    return 'NewsData(author: $author, title: $title, description: $description, url: $url, source: $source, image: $image, category: $category, language: $language, country: $country, publishedAt: $publishedAt)';
  }
}
