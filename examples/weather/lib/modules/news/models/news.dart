import 'package:json_annotation/json_annotation.dart';

import 'package:weather/modules/news/models/news_data.dart';
import 'package:weather/modules/news/models/pagination.dart';

part 'news.g.dart';

@JsonSerializable(explicitToJson: true)
class News {
  final Pagination pagination;
  final List<NewsData> data;

  News({
    required this.pagination,
    required this.data,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  String toString() => 'News(pagination: $pagination, data: $data)';
}
