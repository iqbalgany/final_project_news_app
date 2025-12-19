import 'package:final_project_news_app/models/source_model.dart';

class NewsModel {
  final SourceModel source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
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
