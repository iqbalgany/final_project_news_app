import 'package:equatable/equatable.dart';
import 'package:final_project_news_app/models/news_model.dart';

class NewsState extends Equatable {
  final List<NewsModel>? news;
  final bool loading;
  final String? errorMessage;

  const NewsState({this.news, this.loading = false, this.errorMessage});

  NewsState copyWith({
    List<NewsModel>? news,
    bool? loading,
    String? errorMessage,
  }) {
    return NewsState(
      news: news ?? this.news,
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [news, loading];
}
