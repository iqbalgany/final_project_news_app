import 'package:final_project_news_app/models/source/source_model.dart';
import 'package:hive/hive.dart';

part 'news_model.g.dart';

@HiveType(typeId: 1)
class NewsModel {
  @HiveField(0)
  final SourceModel source;

  @HiveField(1)
  final String? author;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? url;

  @HiveField(5)
  final String? urlToImage;

  @HiveField(6)
  final DateTime? publishedAt;

  @HiveField(7)
  final String? content;

  NewsModel({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    source: SourceModel.fromJson(json["source"]),
    author: json["author"] as String?,
    title: json["title"] as String?,
    description: json["description"] as String?,
    url: json["url"] as String?,
    urlToImage: json["urlToImage"] as String?,
    publishedAt: json["publishedAt"] != null
        ? DateTime.tryParse(json["publishedAt"])
        : null,
    content: json["content"] as String?,
  );
}
