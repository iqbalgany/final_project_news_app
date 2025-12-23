import 'package:final_project_news_app/models/news/news_model.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<NewsModel> savedNews;
  BookmarkLoaded(this.savedNews);
}

class BookmarkStatusChanged extends BookmarkState {
  final bool isSaved;
  final String message;
  BookmarkStatusChanged(this.isSaved, this.message);
}

class BookmarkError extends BookmarkState {
  final String message;
  BookmarkError(this.message);
}
