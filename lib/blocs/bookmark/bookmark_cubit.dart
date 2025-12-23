import 'package:final_project_news_app/blocs/bookmark/bookmark_state.dart';
import 'package:final_project_news_app/data/local_storage/news_local_storage.dart';
import 'package:final_project_news_app/helpers/injection.dart';
import 'package:final_project_news_app/models/news/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final _service = getIt<NewsLocalStorage>();

  BookmarkCubit() : super(BookmarkInitial());

  Future<void> toggleBookmark(NewsModel news) async {
    if (news.url == null) return;

    // 1. Cek status saat ini langsung ke Hive
    final (_, _, isSaved) = await _service.checkIsSaved(news.url!);

    if (isSaved) {
      // 2. Jika sudah ada, hapus
      final (success, message) = await _service.unsaveNews(news.url!);
      if (success) {
        emit(BookmarkStatusChanged(false, message));
      }
    } else {
      // 3. Jika belum ada, simpan
      final (success, message) = await _service.saveNews(news);
      if (success) {
        emit(BookmarkStatusChanged(true, message));
      }
    }

    //
  }

  Future<void> fetchAllSavedNews() async {
    emit(BookmarkLoading());
    try {
      final list = await _service.getAllSavedNews();
      emit(BookmarkLoaded(list));
    } catch (e) {
      emit(BookmarkError('Failed to load data'));
    }
  }
}
