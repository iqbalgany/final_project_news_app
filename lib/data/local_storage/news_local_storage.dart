import 'package:final_project_news_app/models/news/news_model.dart';
import 'package:hive/hive.dart';

class NewsLocalStorage {
  final String _boxName = 'saved_news';

  Future<Box<NewsModel>> get _box async =>
      await Hive.openBox<NewsModel>(_boxName);

  Future<(bool, String, bool)> checkIsSaved(String url) async {
    try {
      final box = await _box;
      bool exists = box.containsKey(url);
      return (true, 'Success', exists);
    } catch (e) {
      return (false, e.toString(), false);
    }
  }

  Future<(bool, String)> saveNews(NewsModel news) async {
    try {
      final box = await _box;

      await box.put(news.url, news);
      return (true, 'Article saved to bookmarks');
    } catch (e) {
      return (false, 'Failed to save articile');
    }
  }

  Future<(bool, String)> unsaveNews(String url) async {
    try {
      final box = await _box;

      await box.delete(url);
      return (true, 'Removed form bookmarks');
    } catch (e) {
      return (false, 'Failed to remove');
    }
  }

  Future<List<NewsModel>> getAllSavedNews() async {
    try {
      final box = await _box;

      return box.values.toList();
    } catch (e) {
      return [];
    }
  }
}
