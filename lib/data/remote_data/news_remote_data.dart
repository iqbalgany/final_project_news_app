import 'package:dio/dio.dart';
import 'package:final_project_news_app/consts/api_key.dart';
import 'package:final_project_news_app/models/news_model.dart';

abstract class NewsRemoteData {
  Future<List<NewsModel>> getNews();
}

class NewsRemoteDataImpl implements NewsRemoteData {
  final Dio _dio = Dio();

  @override
  Future<List<NewsModel>> getNews() async {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {'country': 'us', 'apiKey': newsApiKey},
      );

      return (response.data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
